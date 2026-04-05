import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class PedagogicalReportService {
  const PedagogicalReportService();

  Future<List<PedagogicalReport>> listByChild(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
    required bool guardianView,
    required int limit,
    required int offset,
  }) {
    return PedagogicalReport.db.find(
      session,
      where: (t) {
        var expr =
            t.organizationId.equals(organizationId) &
            t.childId.equals(childId) &
            t.deletedAt.equals(null);
        if (guardianView) {
          expr = expr & (t.visibility.equals('guardian') | t.visibility.equals('all'));
        }
        return expr;
      },
      orderBy: (t) => t.reportDate,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<PedagogicalReport?> getById(
    Session session, {
    required UuidValue reportId,
  }) {
    return PedagogicalReport.db.findById(session, reportId);
  }

  Future<PedagogicalReport> create(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
    required UuidValue createdByUserId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    String status = 'published',
    String visibility = 'guardian',
  }) {
    final now = DateTime.now().toUtc();
    return PedagogicalReport.db.insertRow(
      session,
      PedagogicalReport(
        organizationId: organizationId,
        childId: childId,
        reportDate: reportDate,
        title: title,
        summary: summary,
        body: body,
        status: status,
        visibility: visibility,
        createdByUserId: createdByUserId,
        updatedByUserId: createdByUserId,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<PedagogicalReport> update(
    Session session, {
    required PedagogicalReport report,
    required UuidValue updatedByUserId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) {
    return PedagogicalReport.db.updateRow(
      session,
      report.copyWith(
        reportDate: reportDate,
        title: title,
        summary: summary,
        body: body,
        status: status,
        visibility: visibility,
        updatedByUserId: updatedByUserId,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
