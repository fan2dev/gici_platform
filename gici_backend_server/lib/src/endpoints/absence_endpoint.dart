import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/absence_service.dart';

class AbsenceEndpoint extends Endpoint {
  final _accessControl = const AccessControlService();
  final _absenceService = const AbsenceService();
  final _activityLog = const ActivityLogService();

  /// Report an absence for a child.
  /// Staff/admin can report for any child; guardian can report for own children.
  Future<Absence> reportAbsence(
    Session session, {
    required UuidValue childId,
    required DateTime date,
    String? reason,
    required bool isJustified,
    String? notes,
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

    final absence = await _absenceService.reportAbsence(
      session,
      organizationId: orgId,
      childId: childId,
      date: date,
      reason: reason,
      isJustified: isJustified,
      reportedByUserId: actor.id!,
      notes: notes,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'absence_reported',
      entityType: 'absence',
      entityId: absence.id?.toString(),
    );

    return absence;
  }

  /// List absences for a specific child.
  /// Staff/admin can view any child; guardian can view own children.
  Future<List<Absence>> listAbsencesByChild(
    Session session, {
    required UuidValue childId,
    DateTime? from,
    DateTime? to,
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

    return _absenceService.listAbsencesByChild(
      session,
      organizationId: orgId,
      childId: childId,
      from: from,
      to: to,
    );
  }

  /// List absences for a specific date. Staff/admin only.
  Future<List<Absence>> listAbsencesByDate(
    Session session, {
    required DateTime date,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    return _absenceService.listAbsencesByDate(
      session,
      organizationId: orgId,
      date: date,
    );
  }

  /// List absences for a classroom within an optional date range. Staff/admin only.
  Future<List<Absence>> listAbsencesByClassroom(
    Session session, {
    required UuidValue classroomId,
    DateTime? from,
    DateTime? to,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    return _absenceService.listAbsencesByClassroom(
      session,
      organizationId: orgId,
      classroomId: classroomId,
      from: from,
      to: to,
    );
  }
}
