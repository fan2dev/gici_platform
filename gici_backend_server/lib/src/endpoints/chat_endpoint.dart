import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';

class ChatEndpoint extends Endpoint {
  ChatEndpoint();

  final _accessControl = const AccessControlService();
  final _activityLogService = const ActivityLogService();

  Future<List<ChatConversation>> listConversations(
    Session session, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    final participantRows = await ChatParticipant.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.userId.equals(actor.id!) &
          t.isActive.equals(true),
      limit: 1000,
    );

    if (participantRows.isEmpty) {
      return const [];
    }

    final conversationIds =
        participantRows.map((p) => p.conversationId).toSet();
    var conversations = await ChatConversation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.id.inSet(conversationIds) &
          t.isArchived.equals(false),
      orderBy: (t) => t.lastMessageAt,
      orderDescending: true,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );

    if (actor.role == 'guardian') {
      final allowedChildIds = await _guardianChildIds(
        session,
        organizationId: orgId,
        guardianUserId: actor.id!,
      );

      conversations = conversations.where((c) {
        if (c.relatedChildId == null) {
          return false;
        }
        return allowedChildIds.contains(c.relatedChildId);
      }).toList();
    }

    return conversations;
  }

  Future<ChatConversation> getConversation(
    Session session, {
    required UuidValue conversationId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureParticipant(
      session,
      organizationId: orgId,
      conversationId: conversationId,
      userId: actor.id!,
    );

    final conversation =
        await ChatConversation.db.findById(session, conversationId);
    if (conversation == null ||
        conversation.organizationId != orgId ||
        conversation.isArchived) {
      throw Exception('Conversation not found.');
    }

    return conversation;
  }

  Future<ChatConversation> createConversation(
    Session session, {
    required String conversationType,
    String? title,
    UuidValue? relatedChildId,
    UuidValue? relatedClassroomId,
    required List<UuidValue> participantUserIds,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    if (participantUserIds.isEmpty) {
      throw Exception('Conversation requires at least one participant.');
    }

    final uniqueParticipants = {...participantUserIds, actor.id!}.toList();

    final now = DateTime.now().toUtc();

    if (conversationType == 'direct' && uniqueParticipants.length == 2) {
      final existing = await _findDirectConversation(
        session,
        organizationId: orgId,
        participantUserIds: uniqueParticipants,
      );
      if (existing != null) {
        return existing;
      }
    }

    final conversation = await ChatConversation.db.insertRow(
      session,
      ChatConversation(
        organizationId: orgId,
        title: title,
        conversationType: conversationType,
        relatedChildId: relatedChildId,
        relatedClassroomId: relatedClassroomId,
        createdByUserId: actor.id!,
        isArchived: false,
        lastMessageAt: null,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await ChatParticipant.db.insert(
      session,
      uniqueParticipants
          .map(
            (userId) => ChatParticipant(
              organizationId: orgId,
              conversationId: conversation.id!,
              userId: userId,
              joinedAt: now,
              lastReadMessageId: null,
              lastReadAt: null,
              isActive: true,
              createdAt: now,
              updatedAt: now,
            ),
          )
          .toList(),
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'chat.conversation.create',
      entityType: 'chat_conversation',
      entityId: conversation.id.toString(),
      metadata:
          'type=$conversationType;participants=${uniqueParticipants.join(',')}',
    );

    return conversation;
  }

  Future<ChatMessage> sendMessage(
    Session session, {
    required UuidValue conversationId,
    required String content,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureParticipant(
      session,
      organizationId: orgId,
      conversationId: conversationId,
      userId: actor.id!,
    );

    final now = DateTime.now().toUtc();

    final message = await ChatMessage.db.insertRow(
      session,
      ChatMessage(
        organizationId: orgId,
        conversationId: conversationId,
        senderUserId: actor.id!,
        body: content,
        messageType: 'text',
        metadataJson: null,
        deletedAt: null,
        sentAt: now,
        createdAt: now,
      ),
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      action: 'chat.send_message',
      entityType: 'chat_message',
      entityId: message.id.toString(),
      userId: actor.id!,
      metadata: 'conversationId=$conversationId',
    );

    final conversation =
        await ChatConversation.db.findById(session, conversationId);
    if (conversation != null) {
      await ChatConversation.db.updateRow(
        session,
        conversation.copyWith(lastMessageAt: now, updatedAt: now),
      );
    }

    return message;
  }

  Future<List<ChatMessage>> listMessages(
    Session session, {
    required UuidValue conversationId,
    int page = 0,
    int pageSize = 30,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureParticipant(
      session,
      organizationId: orgId,
      conversationId: conversationId,
      userId: actor.id!,
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    final messages = await ChatMessage.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.conversationId.equals(conversationId) &
          t.deletedAt.equals(null),
      orderBy: (t) => t.sentAt,
      orderDescending: false,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );

    return messages;
  }

  Future<void> markConversationRead(
    Session session, {
    required UuidValue conversationId,
    UuidValue? lastReadMessageId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final participant = await ChatParticipant.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.conversationId.equals(conversationId) &
          t.userId.equals(actor.id!) &
          t.isActive.equals(true),
    );

    if (participant == null) {
      throw Exception('Not a participant of this conversation.');
    }

    await ChatParticipant.db.updateRow(
      session,
      participant.copyWith(
        lastReadMessageId: lastReadMessageId,
        lastReadAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<Map<String, int>> unreadCounts(
    Session session,
  ) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final participants = await ChatParticipant.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.userId.equals(actor.id!) &
          t.isActive.equals(true),
    );

    final result = <String, int>{};
    for (final participant in participants) {
      final messages = await ChatMessage.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(orgId) &
            t.conversationId.equals(participant.conversationId) &
            t.deletedAt.equals(null),
        limit: 2000,
      );

      final lastReadMessageId = participant.lastReadMessageId;
      final unread = lastReadMessageId == null
          ? messages.length
          : messages.where((m) => m.id != null && m.id != lastReadMessageId).length;

      result[participant.conversationId.toString()] = unread;
    }

    return result;
  }

  Future<void> _ensureParticipant(
    Session session, {
    required UuidValue organizationId,
    required UuidValue conversationId,
    required UuidValue userId,
  }) async {
    final participant = await ChatParticipant.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.conversationId.equals(conversationId) &
          t.userId.equals(userId) &
          t.isActive.equals(true),
    );

    if (participant == null) {
      throw Exception(
          'User $userId has no access to conversation $conversationId.');
    }
  }

  Future<Set<UuidValue>> _guardianChildIds(
    Session session, {
    required UuidValue organizationId,
    required UuidValue guardianUserId,
  }) async {
    final relations = await ChildGuardianRelation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.guardianUserId.equals(guardianUserId),
    );
    return relations.map((r) => r.childId).toSet();
  }

  Future<ChatConversation?> _findDirectConversation(
    Session session, {
    required UuidValue organizationId,
    required List<UuidValue> participantUserIds,
  }) async {
    final conversations = await ChatConversation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.conversationType.equals('direct') &
          t.isArchived.equals(false),
      limit: 500,
    );

    for (final conversation in conversations) {
      final participants = await ChatParticipant.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(organizationId) &
            t.conversationId.equals(conversation.id!) &
            t.isActive.equals(true),
      );
      final ids = participants.map((p) => p.userId).toSet();
      final expected = participantUserIds.toSet();
      if (ids.length == expected.length && ids.containsAll(expected)) {
        return conversation;
      }
    }

    return null;
  }
}
