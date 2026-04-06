import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/notification_repository.dart';

enum NotificationsStatus { initial, loading, loaded, error }

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.errorMessage,
  });

  final NotificationsStatus status;
  final List<NotificationRecord> notifications;
  final String? errorMessage;

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationRecord>? notifications,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notifications, errorMessage];
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsState());

  final NotificationRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      final notifications = await _repository.myNotifications(
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: NotificationsStatus.loaded,
        notifications: notifications,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> markRead(UuidValue notificationId) async {
    try {
      await _repository.markNotificationRead(
        notificationId: notificationId,
      );
      // Update local state optimistically
      final updated = state.notifications.map((n) {
        if (n.id == notificationId) {
          // Reload to get server state
          return n;
        }
        return n;
      }).toList();
      emit(state.copyWith(notifications: updated));
      // Reload from server
      await load();
    } catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    String category = 'general',
    String targetScope = 'organization',
    UuidValue? targetClassroomId,
    UuidValue? targetChildId,
    UuidValue? targetUserId,
  }) async {
    try {
      await _repository.createSegmentedNotification(
        title: title,
        body: body,
        category: category,
        targetScope: targetScope,
        targetClassroomId: targetClassroomId,
        targetChildId: targetChildId,
        targetUserId: targetUserId,
      );
    } catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
