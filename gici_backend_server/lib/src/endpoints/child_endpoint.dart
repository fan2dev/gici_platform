import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/child_profile_service.dart';
import '../services/child_service.dart';
import '../services/staff_service.dart';

class ChildEndpoint extends Endpoint {
  ChildEndpoint();

  final _accessControl = const AccessControlService();
  final _childService = const ChildService();
  final _childProfileService = const ChildProfileService();
  final _activityLogService = const ActivityLogService();
  final _staffService = const StaffService();

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

  /// Link a guardian user to a child.
  /// If a user with the given email already exists, links that user.
  /// Otherwise creates a new guardian AppUser first.
  Future<ChildGuardianRelation> linkGuardian(
    Session session, {
    required UuidValue childId,
    required String email,
    required String firstName,
    required String lastName,
    required String relation,
    String? phone,
    String? password,
    bool isPrimary = false,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    // Verify child exists
    final child = await _childService.getById(
      session,
      organizationId: orgId,
      childId: childId,
    );
    if (child == null) {
      throw Exception('Child not found.');
    }

    // Find or create guardian user
    var guardian = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email.toLowerCase()),
    );

    if (guardian == null) {
      guardian = await _staffService.createStaffUser(
        session,
        organizationId: orgId,
        email: email,
        password: password ?? 'changeme123',
        firstName: firstName,
        lastName: lastName,
        role: 'guardian',
        phone: phone,
      );
    }

    // Check if relation already exists
    final existing = await ChildGuardianRelation.db.findFirstRow(
      session,
      where: (t) =>
          t.childId.equals(childId) &
          t.guardianUserId.equals(guardian!.id!),
    );

    if (existing != null) {
      return existing;
    }

    final now = DateTime.now().toUtc();
    final rel = ChildGuardianRelation(
      organizationId: orgId,
      childId: childId,
      guardianUserId: guardian.id!,
      relation: relation,
      isPrimary: isPrimary,
      canPickup: true,
      canViewReports: true,
      canViewPhotos: true,
      createdAt: now,
      updatedAt: now,
    );

    final created = await ChildGuardianRelation.db.insertRow(session, rel);

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'guardian.linked',
      entityType: 'child_guardian_relation',
      entityId: created.id?.toString(),
      metadata: 'childId=$childId;guardianEmail=$email',
    );

    return created;
  }

  /// List guardians linked to a child.
  Future<List<ChildGuardianRelation>> listGuardians(
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

    return ChildGuardianRelation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.childId.equals(childId),
    );
  }
}
