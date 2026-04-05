import 'package:gici_backend_client/gici_backend_server_client.dart';

class NotificationRepository {
  const NotificationRepository(this._client);

  final Client _client;

  Future<PushDeviceToken> registerDeviceToken({
    required String organizationId,
    required String actorId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) {
    return _client.notification.registerDeviceToken(
      organizationId: organizationId,
      actorId: actorId,
      token: token,
      platform: platform,
      deviceId: deviceId,
      deviceModel: deviceModel,
      appVersion: appVersion,
    );
  }

  Future<List<NotificationRecord>> myNotifications({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.notification.myNotifications(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<void> markNotificationRead({
    required String organizationId,
    required String actorId,
    required int notificationId,
  }) {
    return _client.notification.markNotificationRead(
      organizationId: organizationId,
      actorId: actorId,
      notificationId: notificationId,
    );
  }

  Future<int> createSegmentedNotification({
    required String organizationId,
    required String actorId,
    required String title,
    required String body,
    String category = 'general',
    String targetScope = 'organization',
    int? targetClassroomId,
    int? targetChildId,
    int? targetUserId,
  }) {
    return _client.notification.createSegmentedNotification(
      organizationId: organizationId,
      actorId: actorId,
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
