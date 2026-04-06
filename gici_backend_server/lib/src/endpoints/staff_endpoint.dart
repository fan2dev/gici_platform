import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/staff_service.dart';

class StaffEndpoint extends Endpoint {
  final _accessControl = const AccessControlService();
  final _staffService = const StaffService();
  final _activityLog = const ActivityLogService();

  /// List staff members (staff + organization_admin roles).
  Future<List<AppUser>> listStaff(
    Session session, {
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    return _staffService.listStaff(
      session,
      organizationId: orgId,
      page: page,
      pageSize: pageSize,
    );
  }

  /// List guardian users.
  Future<List<AppUser>> listGuardians(
    Session session, {
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    return _staffService.listGuardians(
      session,
      organizationId: orgId,
      page: page,
      pageSize: pageSize,
    );
  }

  /// Create a new staff or admin user.
  Future<AppUser> createStaffUser(
    Session session, {
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    String? phone,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final user = await _staffService.createStaffUser(
      session,
      organizationId: orgId,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      role: role,
      phone: phone,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'staff_user_created',
      entityType: 'app_user',
      entityId: user.id?.toString(),
    );

    return user;
  }

  /// Update a staff user's details.
  Future<AppUser> updateStaffUser(
    Session session, {
    required UuidValue userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    bool? isActive,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final updated = await _staffService.updateStaffUser(
      session,
      userId: userId,
      organizationId: orgId,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      role: role,
      isActive: isActive,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'staff_user_updated',
      entityType: 'app_user',
      entityId: userId.toString(),
    );

    return updated;
  }
}
