import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/tariff_service.dart';

class TariffEndpoint extends Endpoint {
  final _accessControl = const AccessControlService();
  final _tariffService = const TariffService();
  final _activityLog = const ActivityLogService();

  /// List tariffs for the organization.
  /// Admin and staff can view all; guardian can view active tariffs.
  Future<List<Tariff>> listTariffs(
    Session session, {
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    return _tariffService.listTariffs(
      session,
      organizationId: orgId,
      page: page,
      pageSize: pageSize,
    );
  }

  /// Create a new tariff. Admin only.
  Future<Tariff> createTariff(
    Session session, {
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    required bool includesTransport,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final tariff = await _tariffService.createTariff(
      session,
      organizationId: orgId,
      name: name,
      description: description,
      schedule: schedule,
      monthlyPrice: monthlyPrice,
      includesTransport: includesTransport,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'tariff_created',
      entityType: 'tariff',
      entityId: tariff.id?.toString(),
    );

    return tariff;
  }

  /// Update a tariff. Admin only.
  Future<Tariff> updateTariff(
    Session session, {
    required UuidValue tariffId,
    String? name,
    String? description,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
    bool? isActive,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final updated = await _tariffService.updateTariff(
      session,
      tariffId: tariffId,
      organizationId: orgId,
      name: name,
      description: description,
      schedule: schedule,
      monthlyPrice: monthlyPrice,
      includesTransport: includesTransport,
      isActive: isActive,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'tariff_updated',
      entityType: 'tariff',
      entityId: tariffId.toString(),
    );

    return updated;
  }

  /// Assign a tariff to a child. Admin only.
  Future<ChildTariffAssignment> assignTariffToChild(
    Session session, {
    required UuidValue childId,
    required UuidValue tariffId,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final assignment = await _tariffService.assignTariffToChild(
      session,
      organizationId: orgId,
      childId: childId,
      tariffId: tariffId,
      startDate: startDate,
      endDate: endDate,
      notes: notes,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'tariff_assigned_to_child',
      entityType: 'child_tariff_assignment',
      entityId: assignment.id?.toString(),
    );

    return assignment;
  }

  /// List tariff assignments for a child.
  /// Admin/staff can view any child; guardian can view own children.
  Future<List<ChildTariffAssignment>> listChildTariffs(
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

    if (actor.role == 'guardian') {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: childId,
      );
    }

    return _tariffService.listChildTariffs(
      session,
      organizationId: orgId,
      childId: childId,
    );
  }
}
