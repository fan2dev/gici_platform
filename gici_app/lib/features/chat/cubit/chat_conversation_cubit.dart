import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/chat_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

sealed class ChatConversationState extends Equatable {
  const ChatConversationState();

  @override
  List<Object?> get props => [];
}

class ChatConversationInitial extends ChatConversationState {
  const ChatConversationInitial();
}

class ChatConversationLoading extends ChatConversationState {
  const ChatConversationLoading();
}

class ChatConversationLoaded extends ChatConversationState {
  const ChatConversationLoaded({
    required this.messages,
    required this.conversation,
    this.isSending = false,
  });

  final List<ChatMessage> messages;
  final ChatConversation conversation;
  final bool isSending;

  ChatConversationLoaded copyWith({
    List<ChatMessage>? messages,
    ChatConversation? conversation,
    bool? isSending,
  }) {
    return ChatConversationLoaded(
      messages: messages ?? this.messages,
      conversation: conversation ?? this.conversation,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object?> get props => [messages, conversation, isSending];
}

class ChatConversationError extends ChatConversationState {
  const ChatConversationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class ChatConversationCubit extends Cubit<ChatConversationState> {
  ChatConversationCubit(this._repository)
      : super(const ChatConversationInitial());

  final ChatRepository _repository;
  UuidValue? _conversationId;

  Future<void> loadMessages(UuidValue conversationId) async {
    _conversationId = conversationId;
    emit(const ChatConversationLoading());

    try {
      final results = await Future.wait([
        _repository.listMessages(
          conversationId: conversationId,
          page: 0,
          pageSize: 200,
        ),
        _repository.getConversation(conversationId: conversationId),
      ]);

      final messages = results[0] as List<ChatMessage>;
      final conversation = results[1] as ChatConversation;

      emit(ChatConversationLoaded(
        messages: messages,
        conversation: conversation,
      ));

      // Mark as read in the background.
      await _markRead(messages);
    } catch (e) {
      emit(ChatConversationError(e.toString()));
    }
  }

  Future<void> sendMessage(String content) async {
    final currentState = state;
    if (currentState is! ChatConversationLoaded) return;
    if (_conversationId == null) return;

    emit(currentState.copyWith(isSending: true));

    try {
      final message = await _repository.sendMessage(
        conversationId: _conversationId!,
        content: content,
      );

      final updatedMessages = [...currentState.messages, message];
      emit(ChatConversationLoaded(
        messages: updatedMessages,
        conversation: currentState.conversation,
        isSending: false,
      ));
    } catch (e) {
      // Restore previous state without the sending flag.
      emit(currentState.copyWith(isSending: false));
    }
  }

  Future<void> markRead() async {
    final currentState = state;
    if (currentState is! ChatConversationLoaded) return;
    await _markRead(currentState.messages);
  }

  Future<void> _markRead(List<ChatMessage> messages) async {
    if (_conversationId == null || messages.isEmpty) return;
    final lastMessage = messages.last;
    if (lastMessage.id == null) return;
    try {
      await _repository.markConversationRead(
        conversationId: _conversationId!,
        lastReadMessageId: lastMessage.id,
      );
    } catch (_) {
      // Silently ignore mark-read failures.
    }
  }
}
