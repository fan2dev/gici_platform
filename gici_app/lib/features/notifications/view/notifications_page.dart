import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/notifications_cubit.dart';
import '../data/notification_repository.dart';
import 'send_notification_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationsCubit(sl<NotificationRepository>())..load(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final canSend = auth.isStaffOrAbove;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Notificaciones',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: canSend
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => BlocProvider.value(
                      value: context.read<NotificationsCubit>(),
                      child: const SendNotificationPage(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Enviar'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            )
          : null,
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading) {
            return const LoadingState(
              message: 'Cargando notificaciones...',
            );
          }
          if (state.status == NotificationsStatus.error) {
            return ErrorState(
              message:
                  state.errorMessage ?? 'Error al cargar notificaciones',
              onRetry: () => context.read<NotificationsCubit>().load(),
            );
          }
          if (state.notifications.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_none,
              message: 'No tienes notificaciones',
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<NotificationsCubit>().load(),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final item = state.notifications[index];
                final isUnread = !item.isRead;

                return GiciCard(
                  accentColor: isUnread ? Colors.blue : null,
                  onTap: isUnread
                      ? () {
                          context
                              .read<NotificationsCubit>()
                              .markRead(item.id!);
                        }
                      : null,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isUnread
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _categoryIcon(item.category),
                          color: isUnread
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 14,
                                color: isUnread
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.body,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: isUnread
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _relativeTime(item.createdAt),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          if (isUnread) ...[
                            const SizedBox(height: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'alert':
        return Icons.warning_amber_rounded;
      case 'message':
        return Icons.chat_bubble_outline;
      case 'event':
        return Icons.event_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _relativeTime(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Ahora';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return 'Ayer';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${dt.day}/${dt.month}';
  }
}
