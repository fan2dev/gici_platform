import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/child_profile_service.dart';
import '../services/child_service.dart';

class ChildEndpoint extends Endpoint {
  ChildEndpoint();

  final _accessControl = const AccessControlService();
  final _childService = const ChildService();
  final _childProfileService = const ChildProfileService();
  final _activityLogService = const ActivityLogService();

  Future<List<Child>> listChildren(
    Session session, {
    int page = 0,
    int pageSize = 20,
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

    if (actor.role == 'guardian') {
      return _childService.listForGuardian(
        session,
        organizationId: orgId,
        guardianUserId: actor.id!,
        limit: safePageSize,
        offset: safePage * safePageSize,
      );
    }

    return _childService.listByOrganization(
      session,
      organizationId: orgId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<Child> createChild(
    Session session, {
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final child = await _childService.create(
      session,
      organizationId: orgId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'child.create',
      entityType: 'child',
      entityId: child.id?.toString(),
      metadata: 'firstName=$firstName;lastName=$lastName',
    );

    return child;
  }

  Future<Child> getChild(
    Session session, {
    required UuidValue childId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final child = await _childService.getById(
      session,
      organizationId: orgId,
      childId: childId,
    );
    if (child == null) {
      throw Exception('Child not found.');
    }

    if (actor.role == 'guardian') {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: childId,
      );
    }

    return child;
  }

  Future<Child> updateChild(
    Session session, {
    required UuidValue childId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final child = await _childService.getById(
      session,
      organizationId: orgId,
      childId: childId,
    );
    if (child == null) {
      throw Exception('Child not found.');
    }

    final updated = await _childService.update(
      session,
      child: child,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      status: status,
      medicalNotes: medicalNotes,
      dietaryNotes: dietaryNotes,
      allergies: allergies,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'child.update',
      entityType: 'child',
      entityId: updated.id?.toString(),
      metadata: 'childId=$childId',
    );

    return updated;
  }

  Future<ChildProfileOverview> getChildProfileOverview(
    Session session, {
    required UuidValue childId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final child = await _childService.getById(
      session,
      organizationId: orgId,
      childId: childId,
    );
    if (child == null) {
      throw Exception('Child not found.');
    }

    if (actor.role == 'guardian') {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: childId,
      );
    }

    return _childProfileService.getOverview(session, child: child);
  }
}
