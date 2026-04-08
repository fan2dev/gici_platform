import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/chat_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

sealed class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object?> get props => [];
}

class ChatListInitial extends ChatListState {
  const ChatListInitial();
}

class ChatListLoading extends ChatListState {
  const ChatListLoading();
}

class ChatListLoaded extends ChatListState {
  const ChatListLoaded({
    required this.conversations,
    required this.unreadCounts,
  });

  final List<ChatConversation> conversations;
  final Map<String, int> unreadCounts;

  /// If there is exactly one conversation, returns its id as a string
  /// so the UI can auto-navigate (useful for guardians with a single child).
  String? get singleConversationId {
    if (conversations.length == 1) {
      return conversations.first.id?.toString();
    }
    return null;
  }

  @override
  List<Object?> get props => [conversations, unreadCounts];
}

class ChatListError extends ChatListState {
  const ChatListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._repository) : super(const ChatListInitial());

  final ChatRepository _repository;

  Future<void> loadConversations() async {
    emit(const ChatListLoading());
    try {
      final results = await Future.wait([
        _repository.listConversations(page: 0, pageSize: 50),
        _repository.unreadCounts(),
      ]);
      final conversations = results[0] as List<ChatConversation>;
      final unread = results[1] as Map<String, int>;

      emit(ChatListLoaded(
        conversations: conversations,
        unreadCounts: unread,
      ));
    } catch (e) {
      emit(ChatListError(e.toString()));
    }
  }

  Future<void> refresh() async {
    // Keep showing old data while refreshing — only emit loading on first load.
    try {
      final results = await Future.wait([
        _repository.listConversations(page: 0, pageSize: 50),
        _repository.unreadCounts(),
      ]);
      final conversations = results[0] as List<ChatConversation>;
      final unread = results[1] as Map<String, int>;

      emit(ChatListLoaded(
        conversations: conversations,
        unreadCounts: unread,
      ));
    } catch (e) {
      emit(ChatListError(e.toString()));
    }
  }
}
