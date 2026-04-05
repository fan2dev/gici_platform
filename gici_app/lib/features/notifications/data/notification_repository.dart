import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class NotificationRepository {
  const NotificationRepository(this._client);

  final Client _client;

  Future<PushDeviceToken> registerDeviceToken({
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) {
    return _client.notification.registerDeviceToken(
      token: token,
      platform: platform,
      deviceId: deviceId,
      deviceModel: deviceModel,
      appVersion: appVersion,
    );
  }

  Future<List<NotificationRecord>> myNotifications({
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.notification.myNotifications(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<void> markNotificationRead({
    required UuidValue notificationId,
  }) {
    return _client.notification.markNotificationRead(
      notificationId: notificationId,
    );
  }

  Future<int> createSegmentedNotification({
    required String title,
    required String body,
    String category = 'general',
    String targetScope = 'organization',
    UuidValue? targetClassroomId,
    UuidValue? targetChildId,
    UuidValue? targetUserId,
  }) {
    return _client.notification.createSegmentedNotification(
      title: title,
      body: body,
      category: category,
      targetScope: targetScope,
      targetClassroomId: targetClassroomId,
      targetChildId: targetChildId,
      targetUserId: targetUserId,
    );
  }
}
