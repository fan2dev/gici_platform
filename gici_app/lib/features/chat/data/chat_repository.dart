import 'package:gici_backend_client/gici_backend_server_client.dart';

class ChatRepository {
  const ChatRepository(this._client);

  final Client _client;

  Future<List<ChatConversation>> listConversations({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 20,
  }) {
    return _client.chat.listConversations(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<ChatMessage>> listMessages({
    required String organizationId,
    required String actorId,
    required String conversationId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.chat.listMessages(
      organizationId: organizationId,
      actorId: actorId,
      conversationId: conversationId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<ChatConversation> getConversation({
    required String organizationId,
    required String actorId,
    required int conversationId,
  }) {
    return _client.chat.getConversation(
      organizationId: organizationId,
      actorId: actorId,
      conversationId: conversationId,
    );
  }

  Future<ChatConversation> createDirectConversation({
    required String organizationId,
    required String actorId,
    required int otherParticipantUserId,
  }) {
    return _client.chat.createConversation(
      organizationId: organizationId,
      actorId: actorId,
      conversationType: 'direct',
      title: null,
      relatedChildId: null,
      relatedClassroomId: null,
      participantUserIds: [otherParticipantUserId],
    );
  }

  Future<ChatMessage> sendMessage({
    required String organizationId,
    required String actorId,
    required int conversationId,
    required String content,
  }) {
    return _client.chat.sendMessage(
      organizationId: organizationId,
      actorId: actorId,
      conversationId: conversationId.toString(),
      content: content,
    );
  }

  Future<void> markConversationRead({
    required String organizationId,
    required String actorId,
    required int conversationId,
    int? lastReadMessageId,
  }) {
    return _client.chat.markConversationRead(
      organizationId: organizationId,
      actorId: actorId,
      conversationId: conversationId,
      lastReadMessageId: lastReadMessageId,
    );
  }

  Future<Map<String, int>> unreadCounts({
    required String organizationId,
    required String actorId,
  }) {
    return _client.chat.unreadCounts(
      organizationId: organizationId,
      actorId: actorId,
    );
  }
}
