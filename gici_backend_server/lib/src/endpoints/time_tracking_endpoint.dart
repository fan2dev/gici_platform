import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
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
    required String organizationId,
    required String actorId,
    String? notes,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff'
      ],
    );
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
      entityId: entry.id,
      metadata: 'actorId=$actorId',
    );

    return entry;
  }

  Future<TimeEntry> checkOut(
    Session session, {
    required String organizationId,
    required String actorId,
    String? notes,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff'
      ],
    );
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
      entityId: entry.id,
      metadata: 'actorId=$actorId',
    );

    return entry;
  }

  Future<List<TimeEntry>> myEntries(
    Session session, {
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 20,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff'
      ],
    );

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
    required String organizationId,
    required String actorId,
    String? userId,
    DateTime? from,
    DateTime? to,
    int page = 0,
    int pageSize = 50,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin'],
    );

    final filterUserId = userId == null ? null : parseActorId(userId);
    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);

    return _timeTrackingService.listEntries(
      session,
      organizationId: orgId,
      userId: filterUserId,
      from: from,
      to: to,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<TimeEntry> getEntry(
    Session session, {
    required String organizationId,
    required String actorId,
    required int entryId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff'
      ],
    );

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
    required String organizationId,
    required String actorId,
    required int targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin'],
    );

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
      userId: actor.id,
      action: 'time_tracking.correct_entry',
      entityType: 'time_entry',
      entityId: correction.id,
      metadata: 'targetEntryId=$targetEntryId;reason=$correctionReason',
    );

    return correction;
  }
}
