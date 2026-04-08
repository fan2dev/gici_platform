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

  /// Create a new user (staff, admin, other_staff, or guardian).
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
      'staff',
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

  /// Assign a classroom permission to a staff user.
  Future<StaffClassroomPermission> assignClassroomPermission(
    Session session, {
    required UuidValue userId,
    required UuidValue classroomId,
    required String role,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final permission = await _staffService.assignClassroomPermission(
      session,
      organizationId: orgId,
      userId: userId,
      classroomId: classroomId,
      role: role,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'classroom_permission_assigned',
      entityType: 'staff_classroom_permission',
      entityId: permission.id?.toString(),
    );

    return permission;
  }

  /// Remove a classroom permission from a staff user.
  Future<void> removeClassroomPermission(
    Session session, {
    required UuidValue userId,
    required UuidValue classroomId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    await _staffService.removeClassroomPermission(
      session,
      organizationId: orgId,
      userId: userId,
      classroomId: classroomId,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'classroom_permission_removed',
      entityType: 'staff_classroom_permission',
      entityId: '${userId}_$classroomId',
    );
  }

  /// List classroom permissions. If userId is provided, filters to that user.
  Future<List<StaffClassroomPermission>> listStaffPermissions(
    Session session, {
    UuidValue? userId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    return _staffService.listStaffPermissions(
      session,
      organizationId: orgId,
      userId: userId,
    );
  }
}
