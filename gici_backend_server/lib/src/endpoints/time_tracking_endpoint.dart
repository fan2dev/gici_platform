import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/time_tracking_service.dart';

class TimeTrackingEndpoint extends Endpoint {
  TimeTrackingEndpoint();

  final _accessControl = const AccessControlService();
  final _timeTrackingService = const TimeTrackingService();
  final _activityLogService = const ActivityLogService();

  Future<TimeEntry> checkIn(
    Session session, {
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;
    final userId = actor.id!;

    final entry = await _timeTrackingService.register(
      session,
      organizationId: orgId,
      userId: userId,
      createdByUserId: userId,
      entryType: 'check_in',
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: userId,
      action: 'time_tracking.check_in',
      entityType: 'time_entry',
      entityId: entry.id?.toString(),
    );

    return entry;
  }

  Future<TimeEntry> checkOut(
    Session session, {
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;
    final userId = actor.id!;

    final entry = await _timeTrackingService.register(
      session,
      organizationId: orgId,
      userId: userId,
      createdByUserId: userId,
      entryType: 'check_out',
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: userId,
      action: 'time_tracking.check_out',
      entityType: 'time_entry',
      entityId: entry.id?.toString(),
    );

    return entry;
  }

  Future<List<TimeEntry>> myEntries(
    Session session, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;
    final userId = actor.id!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _timeTrackingService.myEntries(
      session,
      organizationId: orgId,
      userId: userId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<List<TimeEntry>> listEntries(
    Session session, {
    UuidValue? userId,
    DateTime? from,
    DateTime? to,
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin']);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);

    return _timeTrackingService.listEntries(
      session,
      organizationId: orgId,
      userId: userId,
      from: from,
      to: to,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<TimeEntry> getEntry(
    Session session, {
    required UuidValue entryId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _timeTrackingService.getById(session, entryId: entryId);
    if (entry == null || entry.organizationId != orgId) {
      throw Exception('Entry not found.');
    }

    if (actor.role == 'staff' && entry.userId != actor.id) {
      throw Exception('Staff can only access own entries.');
    }

    return entry;
  }

  Future<TimeEntry> correctEntry(
    Session session, {
    required UuidValue targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin']);
    final orgId = actor.organizationId!;

    final original = await _timeTrackingService.getById(
      session,
      entryId: targetEntryId,
    );
    if (original == null || original.organizationId != orgId) {
      throw Exception('Original entry not found.');
    }

    final correction = await _timeTrackingService.createCorrection(
      session,
      organizationId: orgId,
      userId: original.userId,
      createdByUserId: actor.id!,
      parentEntryId: original.id!,
      correctedEntryType: correctedEntryType,
      correctionReason: correctionReason,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'time_tracking.correct_entry',
      entityType: 'time_entry',
      entityId: correction.id?.toString(),
      metadata: 'targetEntryId=$targetEntryId;reason=$correctionReason',
    );

    return correction;
  }

  /// Export time entries as CSV string for Spanish labor law compliance
  /// (Registro diario de jornada).
  Future<String> exportTimeEntries(
    Session session, {
    required DateTime from,
    required DateTime to,
    UuidValue? userId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final entries = await _timeTrackingService.listEntries(
      session,
      organizationId: orgId,
      userId: userId,
      from: from,
      to: to,
      limit: 10000,
      offset: 0,
    );

    // Build CSV: Spanish labor law requires employee name, date, check-in, check-out
    final buffer = StringBuffer();
    buffer.writeln('Empleado ID,Tipo,Fecha,Hora,Motivo corrección,Notas');

    for (final entry in entries) {
      final date = entry.recordedAt.toIso8601String().split('T')[0];
      final time = entry.recordedAt.toIso8601String().split('T')[1].split('.')[0];
      final correction = entry.correctionReason ?? '';
      final notes = entry.notes?.replaceAll(',', ';') ?? '';
      buffer.writeln(
          '${entry.userId},${entry.entryType},$date,$time,$correction,$notes');
    }

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'time_tracking.export',
      metadata: 'from=${from.toIso8601String()};to=${to.toIso8601String()}',
    );

    return buffer.toString();
  }
}
