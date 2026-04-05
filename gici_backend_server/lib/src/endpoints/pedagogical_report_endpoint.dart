import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/pedagogical_report_service.dart';

class PedagogicalReportEndpoint extends Endpoint {
  PedagogicalReportEndpoint();

  final _accessControl = const AccessControlService();
  final _reportService = const PedagogicalReportService();
  final _activityLogService = const ActivityLogService();

  Future<List<PedagogicalReport>> listReportsByChild(
    Session session, {
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 30,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    if (actor.role == 'guardian') {
      final canAccess = await _accessControl.isGuardianOfChild(
        session,
        organizationId: orgId,
        guardianUserId: actor.id!,
        childId: childId,
      );
      if (!canAccess) {
        throw Exception('Guardian cannot access these reports.');
      }
    }

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _reportService.listByChild(
      session,
      organizationId: orgId,
      childId: childId,
      guardianView: actor.role == 'guardian',
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<PedagogicalReport> getReport(
    Session session, {
    required String organizationId,
    required String actorId,
    required int reportId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    final report = await _reportService.getById(session, reportId: reportId);
    if (report == null || report.organizationId != orgId || report.deletedAt != null) {
      throw Exception('Report not found.');
    }

    if (actor.role == 'guardian') {
      final canAccess = await _accessControl.isGuardianOfChild(
        session,
        organizationId: orgId,
        guardianUserId: actor.id!,
        childId: report.childId,
      );
      if (!canAccess) {
        throw Exception('Guardian cannot access this report.');
      }
      if (report.visibility != 'guardian' && report.visibility != 'all') {
        throw Exception('Report is not visible to guardian.');
      }
    }

    return report;
  }

  Future<PedagogicalReport> createReport(
    Session session, {
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    String status = 'published',
    String visibility = 'guardian',
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final report = await _reportService.create(
      session,
      organizationId: orgId,
      childId: childId,
      createdByUserId: actor.id!,
      reportDate: reportDate,
      title: title,
      summary: summary,
      body: body,
      status: status,
      visibility: visibility,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'pedagogical_report.create',
      entityType: 'pedagogical_report',
      entityId: report.id,
      metadata: 'childId=$childId;status=$status',
    );

    return report;
  }

  Future<PedagogicalReport> updateReport(
    Session session, {
    required String organizationId,
    required String actorId,
    required int reportId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final report = await _reportService.getById(session, reportId: reportId);
    if (report == null || report.organizationId != orgId || report.deletedAt != null) {
      throw Exception('Report not found.');
    }

    final updated = await _reportService.update(
      session,
      report: report,
      updatedByUserId: actor.id!,
      reportDate: reportDate,
      title: title,
      summary: summary,
      body: body,
      status: status,
      visibility: visibility,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'pedagogical_report.update',
      entityType: 'pedagogical_report',
      entityId: updated.id,
      metadata: 'reportId=$reportId',
    );

    return updated;
  }
}
