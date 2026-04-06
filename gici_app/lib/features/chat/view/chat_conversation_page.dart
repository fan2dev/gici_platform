import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/chat_conversation_cubit.dart';
import '../data/chat_repository.dart';

class ChatConversationPage extends StatelessWidget {
  const ChatConversationPage({super.key, required this.conversationId});

  final UuidValue conversationId;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    if (!authState.isAuthenticated || authState.organizationId == null) {
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    return BlocProvider(
      create: (_) => ChatConversationCubit(sl<ChatRepository>())
        ..loadMessages(conversationId),
      child: _ChatConversationBody(conversationId: conversationId),
    );
  }
}

class _ChatConversationBody extends StatefulWidget {
  const _ChatConversationBody({required this.conversationId});

  final UuidValue conversationId;

  @override
  State<_ChatConversationBody> createState() => _ChatConversationBodyState();
}

class _ChatConversationBodyState extends State<_ChatConversationBody> {
  final _composerController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _composerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSend() async {
    final content = _composerController.text.trim();
    if (content.isEmpty) return;
    _composerController.clear();
    await context.read<ChatConversationCubit>().sendMessage(content);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/chat'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: BlocBuilder<ChatConversationCubit, ChatConversationState>(
          builder: (context, state) {
            if (state is ChatConversationLoaded) {
              final convo = state.conversation;
              final title =
                  convo.title ?? _fallbackTitle(convo.conversationType);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _conversationSubtitle(convo.conversationType),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }
            return const Text(
              'Chat',
              style: TextStyle(fontWeight: FontWeight.w700),
            );
          },
        ),
      ),
      body: BlocConsumer<ChatConversationCubit, ChatConversationState>(
        listener: (context, state) {
          if (state is ChatConversationLoaded) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          return switch (state) {
            ChatConversationInitial() ||
            ChatConversationLoading() =>
              const LoadingState(message: 'Cargando mensajes...'),
            ChatConversationError(:final message) => ErrorState(
                message: message,
                onRetry: () => context
                    .read<ChatConversationCubit>()
                    .loadMessages(widget.conversationId),
              ),
            ChatConversationLoaded(
              :final messages,
              :final conversation,
              :final isSending,
            ) =>
              Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 48,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No hay mensajes. Envia el primero.',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _MessageList(
                            messages: messages,
                            conversation: conversation,
                            currentUserId: auth.userId,
                            scrollController: _scrollController,
                          ),
                  ),
                  _ComposerBar(
                    controller: _composerController,
                    isSending: isSending,
                    onSend: _handleSend,
                  ),
                ],
              ),
          };
        },
      ),
    );
  }

  String _fallbackTitle(String type) {
    switch (type) {
      case 'direct':
        return 'Conversacion directa';
      case 'group':
        return 'Grupo';
      case 'child_context':
        return 'Sobre alumno/a';
      default:
        return 'Chat';
    }
  }

  String _conversationSubtitle(String type) {
    switch (type) {
      case 'direct':
        return 'Conversacion directa';
      case 'group':
        return 'Grupo';
      case 'child_context':
        return 'Contexto alumno/a';
      default:
        return type;
    }
  }
}

// ---------------------------------------------------------------------------
// Message list
// ---------------------------------------------------------------------------

class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    required this.conversation,
    required this.currentUserId,
    required this.scrollController,
  });

  final List<dynamic> messages;
  final dynamic conversation;
  final UuidValue? currentUserId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMine = message.senderUserId == currentUserId;
        final isGroup = conversation.conversationType != 'direct';

        final showDateHeader = index == 0 ||
            !_isSameDay(messages[index - 1].sentAt, message.sentAt);

        return Column(
          children: [
            if (showDateHeader) _DateHeader(date: message.sentAt),
            _MessageBubble(
              message: message,
              isMine: isMine,
              showSenderName: isGroup && !isMine,
            ),
          ],
        );
      },
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

// ---------------------------------------------------------------------------
// Date header
// ---------------------------------------------------------------------------

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final diff = now.difference(date);
    String label;
    if (diff.inDays == 0) {
      label = 'Hoy';
    } else if (diff.inDays == 1) {
      label = 'Ayer';
    } else {
      label = DateFormat.yMMMd('es').format(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Message bubble
// ---------------------------------------------------------------------------

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isMine,
    this.showSenderName = false,
  });

  final dynamic message;
  final bool isMine;
  final bool showSenderName;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final bubbleRadius = isMine
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(4),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(20),
          );

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (showSenderName)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, left: 12),
                  child: Text(
                    message.senderUserId.toString().substring(0, 8),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isMine
                      ? primary.withValues(alpha: 0.1)
                      : Colors.white,
                  borderRadius: bubbleRadius,
                  border: isMine
                      ? null
                      : Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.body,
                      style: TextStyle(
                        fontSize: 14,
                        color: isMine
                            ? primary.withValues(alpha: 0.9)
                            : Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat.Hm().format(message.sentAt),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Composer bar
// ---------------------------------------------------------------------------

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F7),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  isDense: true,
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: isSending ? null : onSend,
                icon: isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
