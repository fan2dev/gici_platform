import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../data/chat_repository.dart';
import '../../auth/cubit/auth_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _directUserController = TextEditingController();

  @override
  void dispose() {
    _directUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final repo = sl<ChatRepository>();

    if (!authState.isAuthenticated ||
        authState.organizationId == null ||
        authState.actorId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<(List<ChatConversation>, Map<String, int>)>(
        future: () async {
          final conversations = await repo.listConversations(
            organizationId: authState.organizationId!,
            actorId: authState.actorId!,
            page: 0,
            pageSize: 30,
          );
          final unread = await repo.unreadCounts(
            organizationId: authState.organizationId!,
            actorId: authState.actorId!,
          );
          return (conversations, unread);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Chat load error: ${snapshot.error}'));
          }

          final items = snapshot.data?.$1 ?? const <ChatConversation>[];
          final unread = snapshot.data?.$2 ?? const <String, int>{};
          if (items.isEmpty) {
            return const Center(child: Text('No conversations yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                tileColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () => context.go('/chat/${item.id}'),
                title: Text(item.title ?? 'Conversation #${item.id}'),
                subtitle: Text('Type: ${item.conversationType}'),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item.lastMessageAt?.toIso8601String() ?? '-'),
                    Text('Unread: ${unread[item.id.toString()] ?? 0}'),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Create direct conversation'),
              content: TextField(
                controller: _directUserController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Participant user id',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    final participantId = int.tryParse(
                      _directUserController.text,
                    );
                    if (participantId == null) {
                      return;
                    }
                    final conversation = await repo.createDirectConversation(
                      organizationId: authState.organizationId!,
                      actorId: authState.actorId!,
                      otherParticipantUserId: participantId,
                    );
                    _directUserController.clear();
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                    if (!context.mounted) return;
                    setState(() {});
                    context.go('/chat/${conversation.id}');
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          );
        },
        label: const Text('Direct'),
      ),
    );
  }
}
