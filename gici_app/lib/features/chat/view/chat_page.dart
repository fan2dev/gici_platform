import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/chat_list_cubit.dart';
import '../data/chat_repository.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    if (!authState.isAuthenticated || authState.organizationId == null) {
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    return BlocProvider(
      create: (_) =>
          ChatListCubit(sl<ChatRepository>())..loadConversations(),
      child: const _ChatPageBody(),
    );
  }
}

class _ChatPageBody extends StatelessWidget {
  const _ChatPageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/chat/create'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.edit_outlined, color: Colors.white),
      ),
      body: BlocBuilder<ChatListCubit, ChatListState>(
        builder: (context, state) {
          return switch (state) {
            ChatListInitial() ||
            ChatListLoading() =>
              const LoadingState(message: 'Cargando conversaciones...'),
            ChatListError(:final message) => ErrorState(
                message: message,
                onRetry: () =>
                    context.read<ChatListCubit>().loadConversations(),
              ),
            ChatListLoaded(:final conversations, :final unreadCounts) =>
              conversations.isEmpty
                  ? EmptyState(
                      icon: Icons.chat_bubble_outline,
                      message:
                          'No tienes conversaciones todavia.\nPulsa el boton para iniciar una.',
                      action: FilledButton.icon(
                        onPressed: () => context.push('/chat/create'),
                        icon: const Icon(Icons.add),
                        label: const Text('Nueva conversacion'),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    )
                  : _ConversationList(
                      conversations: conversations,
                      unreadCounts: unreadCounts,
                    ),
          };
        },
      ),
    );
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList({
    required this.conversations,
    required this.unreadCounts,
  });

  final List<dynamic> conversations;
  final Map<String, int> unreadCounts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ChatListCubit>().refresh(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final convo = conversations[index];
          final unread = unreadCounts[convo.id.toString()] ?? 0;

          return _ConversationTile(
            conversation: convo,
            unreadCount: unread,
          );
        },
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.conversation,
    required this.unreadCount,
  });

  final dynamic conversation;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasUnread = unreadCount > 0;

    final title = conversation.title ?? _fallbackTitle(conversation);
    final subtitle = _lastMessagePreview(conversation);
    final timeText = _formatRelativeTime(conversation.lastMessageAt);
    final isGroup = conversation.conversationType == 'group';

    return GiciCard(
      onTap: () => context.push('/chat/${conversation.id}'),
      accentColor: hasUnread ? Colors.blue : null,
      child: Row(
        children: [
          GiciAvatar(
            name: title,
            radius: 24,
            badge: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isGroup ? '\u{1F465}' : '\u{1F4AC}',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight:
                              hasUnread ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeText,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: hasUnread
                            ? theme.colorScheme.primary
                            : Colors.grey.shade500,
                        fontWeight:
                            hasUnread ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    if (hasUnread) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            unreadCount > 99
                                ? '99+'
                                : unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fallbackTitle(dynamic convo) {
    final type = convo.conversationType as String;
    if (type == 'direct') return 'Conversacion directa';
    if (type == 'group') return 'Grupo';
    if (type == 'child_context') return 'Sobre alumno/a';
    return 'Conversacion';
  }

  String _lastMessagePreview(dynamic convo) {
    switch (convo.conversationType as String) {
      case 'direct':
        return 'Conversacion directa';
      case 'group':
        return 'Grupo';
      case 'child_context':
        return 'Contexto alumno/a';
      default:
        return convo.conversationType as String;
    }
  }

  String _formatRelativeTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Ahora';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    if (diff.inDays == 1) return 'Ayer';
    if (diff.inDays < 7) return DateFormat.E('es').format(dateTime);
    return DateFormat('d MMM', 'es').format(dateTime);
  }
}
