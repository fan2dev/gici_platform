import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/notification_service.dart';

class NotificationEndpoint extends Endpoint {
  NotificationEndpoint();

  final _accessControl = const AccessControlService();
  final _notificationService = const NotificationService();
  final _activityLogService = const ActivityLogService();

  Future<PushDeviceToken> registerDeviceToken(
    Session session, {
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    return _notificationService.registerDeviceToken(
      session,
      organizationId: orgId,
      userId: actor.id!,
      token: token,
      platform: platform,
      deviceId: deviceId,
      deviceModel: deviceModel,
      appVersion: appVersion,
    );
  }

  Future<void> removeDeviceToken(
    Session session, {
    required String token,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _notificationService.removeDeviceToken(
      session,
      organizationId: orgId,
      userId: actor.id!,
      token: token,
    );
  }

  Future<List<NotificationRecord>> myNotifications(
    Session session, {
    int page = 0,
    int pageSize = 30,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _notificationService.listMyNotifications(
      session,
      organizationId: orgId,
      userId: actor.id!,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<void> markNotificationRead(
    Session session, {
    required UuidValue notificationId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _notificationService.markAsRead(
      session,
      organizationId: orgId,
      userId: actor.id!,
      notificationId: notificationId,
    );
  }

  Future<int> createSegmentedNotification(
    Session session, {
    required String title,
    required String body,
    required String category,
    required String targetScope,
    UuidValue? targetClassroomId,
    UuidValue? targetChildId,
    UuidValue? targetUserId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final createdCount = await _notificationService.createSegmentedNotification(
      session,
      organizationId: orgId,
      createdByUserId: actor.id!,
      title: title,
      body: body,
      category: category,
      targetScope: targetScope,
      targetClassroomId: targetClassroomId,
      targetChildId: targetChildId,
      targetUserId: targetUserId,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'notification.create_segmented',
      entityType: 'notification_record',
      metadata: 'targetScope=$targetScope;count=$createdCount',
    );

    return createdCount;
  }
}
