import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/notification_repository.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _canPublish(AppRole? role) {
    return role == AppRole.organizationAdmin ||
        role == AppRole.platformSuperAdmin ||
        role == AppRole.staff;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<NotificationRepository>();

    if (!auth.isAuthenticated ||
        auth.organizationId == null ||
        auth.actorId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<NotificationRecord>>(
        future: repo.myNotifications(
          organizationId: auth.organizationId!,
          actorId: auth.actorId!,
          page: 0,
          pageSize: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Load error: ${snapshot.error}'));
          }

          final notifications = snapshot.data ?? const <NotificationRecord>[];
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.body),
                trailing: item.isRead
                    ? const Icon(Icons.done_all)
                    : TextButton(
                        onPressed: () async {
                          await repo.markNotificationRead(
                            organizationId: auth.organizationId!,
                            actorId: auth.actorId!,
                            notificationId: item.id!,
                          );
                          if (mounted) setState(() {});
                        },
                        child: const Text('Mark read'),
                      ),
              );
            },
          );
        },
      ),
      floatingActionButton: _canPublish(auth.role)
          ? FloatingActionButton.extended(
              onPressed: () async {
                await repo.createSegmentedNotification(
                  organizationId: auth.organizationId!,
                  actorId: auth.actorId!,
                  title: 'Update',
                  body: 'New update from center',
                  category: 'general',
                  targetScope: 'organization',
                );
                if (mounted) setState(() {});
              },
              label: const Text('Broadcast'),
            )
          : null,
    );
  }
}
