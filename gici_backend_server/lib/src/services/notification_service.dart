import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class NotificationService {
  const NotificationService();

  Future<PushDeviceToken> registerDeviceToken(
    Session session, {
    required int organizationId,
    required int userId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) async {
    final now = DateTime.now().toUtc();
    final existing = await PushDeviceToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
    );

    if (existing != null) {
      final updated = existing.copyWith(
        organizationId: organizationId,
        userId: userId,
        platform: platform,
        deviceId: deviceId,
        deviceModel: deviceModel,
        appVersion: appVersion,
        isActive: true,
        lastUsedAt: now,
        updatedAt: now,
      );
      return PushDeviceToken.db.updateRow(session, updated);
    }

    return PushDeviceToken.db.insertRow(
      session,
      PushDeviceToken(
        organizationId: organizationId,
        userId: userId,
        token: token,
        platform: platform,
        deviceId: deviceId,
        deviceModel: deviceModel,
        appVersion: appVersion,
        isActive: true,
        lastUsedAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> removeDeviceToken(
    Session session, {
    required int organizationId,
    required int userId,
    required String token,
  }) async {
    final row = await PushDeviceToken.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.userId.equals(userId) &
          t.token.equals(token),
    );
    if (row == null) {
      return;
    }

    await PushDeviceToken.db.updateRow(
      session,
      row.copyWith(
        isActive: false,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<NotificationRecord>> listMyNotifications(
    Session session, {
    required int organizationId,
    required int userId,
    required int limit,
    required int offset,
  }) {
    return NotificationRecord.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<void> markAsRead(
    Session session, {
    required int organizationId,
    required int userId,
    required int notificationId,
  }) async {
    final row = await NotificationRecord.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(notificationId) &
          t.organizationId.equals(organizationId) &
          t.userId.equals(userId),
    );

    if (row == null) {
      throw Exception('Notification not found.');
    }

    await NotificationRecord.db.updateRow(
      session,
      row.copyWith(
        isRead: true,
        readAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<int> createSegmentedNotification(
    Session session, {
    required int organizationId,
    required int createdByUserId,
    required String title,
    required String body,
    required String category,
    required String targetScope,
    int? targetClassroomId,
    int? targetChildId,
    int? targetUserId,
  }) async {
    final recipientIds = await _resolveRecipients(
      session,
      organizationId: organizationId,
      targetScope: targetScope,
      targetClassroomId: targetClassroomId,
      targetChildId: targetChildId,
      targetUserId: targetUserId,
    );

    if (recipientIds.isEmpty) {
      return 0;
    }

    final now = DateTime.now().toUtc();
    await NotificationRecord.db.insert(
      session,
      recipientIds
          .map(
            (recipientUserId) => NotificationRecord(
              organizationId: organizationId,
              userId: recipientUserId,
              title: title,
              body: body,
              category: category,
              targetScope: targetScope,
              targetClassroomId: targetClassroomId,
              targetChildId: targetChildId,
              targetUserId: targetUserId,
              createdByUserId: createdByUserId,
              isRead: false,
              readAt: null,
              createdAt: now,
            ),
          )
          .toList(),
    );

    return recipientIds.length;
  }

  Future<Set<int>> _resolveRecipients(
    Session session, {
    required int organizationId,
    required String targetScope,
    int? targetClassroomId,
    int? targetChildId,
    int? targetUserId,
  }) async {
    switch (targetScope) {
      case 'organization':
        final users = await AppUser.db.find(
          session,
          where: (t) =>
              t.organizationId.equals(organizationId) &
              t.deletedAt.equals(null) &
              t.isActive.equals(true),
          limit: 5000,
        );
        return users.map((u) => u.id!).toSet();
      case 'user':
        if (targetUserId == null) {
          throw Exception('targetUserId is required for user scope.');
        }
        return {targetUserId};
      case 'child':
        if (targetChildId == null) {
          throw Exception('targetChildId is required for child scope.');
        }
        final relations = await ChildGuardianRelation.db.find(
          session,
          where: (t) =>
              t.organizationId.equals(organizationId) &
              t.childId.equals(targetChildId),
          limit: 1000,
        );
        return relations.map((r) => r.guardianUserId).toSet();
      case 'classroom':
        if (targetClassroomId == null) {
          throw Exception('targetClassroomId is required for classroom scope.');
        }
        final assignments = await ClassroomAssignment.db.find(
          session,
          where: (t) =>
              t.organizationId.equals(organizationId) &
              t.classroomId.equals(targetClassroomId) &
              t.status.equals('active') &
              t.withdrawnAt.equals(null),
          limit: 5000,
        );
        final childIds = assignments.map((a) => a.childId).toSet();
        if (childIds.isEmpty) {
          return <int>{};
        }
        final relations = await ChildGuardianRelation.db.find(
          session,
          where: (t) =>
              t.organizationId.equals(organizationId) & t.childId.inSet(childIds),
          limit: 5000,
        );
        return relations.map((r) => r.guardianUserId).toSet();
      default:
        throw Exception('Unknown target scope: $targetScope');
    }
  }
}
