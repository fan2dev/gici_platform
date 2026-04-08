import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class AbsenceService {
  const AbsenceService();

  Future<Absence> reportAbsence(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
    required DateTime date,
    String? reason,
    required bool isJustified,
    required UuidValue reportedByUserId,
    String? notes,
  }) async {
    final now = DateTime.now().toUtc();

    final absence = Absence(
      organizationId: organizationId,
      childId: childId,
      date: date,
      reason: reason,
      isJustified: isJustified,
      reportedByUserId: reportedByUserId,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );

    return await Absence.db.insertRow(session, absence);
  }

  Future<List<Absence>> listAbsencesByChild(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
    DateTime? from,
    DateTime? to,
  }) async {
    return await Absence.db.find(
      session,
      where: (t) {
        var condition = t.organizationId.equals(organizationId) &
            t.childId.equals(childId);
        if (from != null) {
          condition = condition & t.date.notEquals(null) &
              (t.date >= from);
        }
        if (to != null) {
          condition = condition & (t.date <= to);
        }
        return condition;
      },
      orderBy: (t) => t.date,
    );
  }

  Future<List<Absence>> listAbsencesByDate(
    Session session, {
    required UuidValue organizationId,
    required DateTime date,
  }) async {
    return await Absence.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.date.equals(date),
      orderBy: (t) => t.childId,
    );
  }

  Future<List<Absence>> listAbsencesByClassroom(
    Session session, {
    required UuidValue organizationId,
    required UuidValue classroomId,
    DateTime? from,
    DateTime? to,
  }) async {
    // First get children assigned to the classroom
    final assignments = await ClassroomAssignment.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.classroomId.equals(classroomId) &
          t.status.equals('active'),
    );

    if (assignments.isEmpty) return [];

    final childIds = assignments.map((a) => a.childId).toSet();

    // Then get absences for those children
    return await Absence.db.find(
      session,
      where: (t) {
        var condition = t.organizationId.equals(organizationId) &
            t.childId.inSet(childIds);
        if (from != null) {
          condition = condition & (t.date >= from);
        }
        if (to != null) {
          condition = condition & (t.date <= to);
        }
        return condition;
      },
      orderBy: (t) => t.date,
    );
  }
}
