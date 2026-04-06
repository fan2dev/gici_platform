import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class ChatRepository {
  const ChatRepository(this._client);

  final Client _client;

  Future<List<ChatConversation>> listConversations({
    int page = 0,
    int pageSize = 20,
  }) {
    return _client.chat.listConversations(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<ChatMessage>> listMessages({
    required UuidValue conversationId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.chat.listMessages(
      conversationId: conversationId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<ChatConversation> getConversation({
    required UuidValue conversationId,
  }) {
    return _client.chat.getConversation(
      conversationId: conversationId,
    );
  }

  Future<ChatConversation> createDirectConversation({
    required UuidValue otherParticipantUserId,
  }) {
    return _client.chat.createConversation(
      conversationType: 'direct',
      title: null,
      relatedChildId: null,
      relatedClassroomId: null,
      participantUserIds: [otherParticipantUserId],
    );
  }

  Future<ChatConversation> createConversation({
    required String conversationType,
    String? title,
    UuidValue? relatedChildId,
    UuidValue? relatedClassroomId,
    required List<UuidValue> participantUserIds,
  }) {
    return _client.chat.createConversation(
      conversationType: conversationType,
      title: title,
      relatedChildId: relatedChildId,
      relatedClassroomId: relatedClassroomId,
      participantUserIds: participantUserIds,
    );
  }

  Future<ChatMessage> sendMessage({
    required UuidValue conversationId,
    required String content,
  }) {
    return _client.chat.sendMessage(
      conversationId: conversationId,
      content: content,
    );
  }

  Future<void> markConversationRead({
    required UuidValue conversationId,
    UuidValue? lastReadMessageId,
  }) {
    return _client.chat.markConversationRead(
      conversationId: conversationId,
      lastReadMessageId: lastReadMessageId,
    );
  }

  Future<Map<String, int>> unreadCounts() {
    return _client.chat.unreadCounts();
  }
}
