import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ChildProfileService {
  const ChildProfileService();

  Future<ChildProfileOverview> getOverview(
    Session session, {
    required Child child,
  }) async {
    final organizationId = child.organizationId;
    final childId = child.id!;

    final activeAssignmentFuture = ClassroomAssignment.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId) &
          t.status.equals('active') &
          t.withdrawnAt.equals(null),
      orderBy: (t) => t.assignedAt,
      orderDescending: true,
    );

    final relationsFuture = ChildGuardianRelation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      limit: 50,
    );

    final docsFuture = ChildDocument.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId) &
          t.deletedAt.equals(null),
      limit: 1,
    );

    final reportsFuture = PedagogicalReport.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId) &
          t.deletedAt.equals(null),
      limit: 1,
    );

    final latestMealFuture = MealEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: 1,
    );

    final latestNapFuture = NapEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.startedAt,
      orderDescending: true,
      limit: 1,
    );

    final latestBowelFuture = BowelMovementEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.eventAt,
      orderDescending: true,
      limit: 1,
    );

    final assignment = await activeAssignmentFuture;
    final relations = await relationsFuture;
    final docs = await docsFuture;
    final reports = await reportsFuture;
    final latestMeal = await latestMealFuture;
    final latestNap = await latestNapFuture;
    final latestBowel = await latestBowelFuture;

    String? classroomName;
    if (assignment?.classroomId != null) {
      final classroom =
          await Classroom.db.findById(session, assignment!.classroomId);
      classroomName = classroom?.name;
    }

    final guardianUserIds = relations.map((e) => e.guardianUserId).toList();
    final guardianUserIdSet = guardianUserIds.toSet();
    final guardianUsers = guardianUserIds.isEmpty
        ? const <AppUser>[]
        : await AppUser.db.find(
            session,
            where: (t) => t.id.inSet(guardianUserIdSet),
            limit: 100,
          );

    DateTime? lastHabitAt;
    final candidates = <DateTime?>[
      latestMeal.firstOrNull?.recordedAt,
      latestNap.firstOrNull?.startedAt,
      latestBowel.firstOrNull?.eventAt,
    ].whereType<DateTime>().toList();
    if (candidates.isNotEmpty) {
      candidates.sort((a, b) => b.compareTo(a));
      lastHabitAt = candidates.first;
    }

    return ChildProfileOverview(
      child: child,
      activeClassroomId: assignment?.classroomId,
      activeClassroomName: classroomName,
      guardianUserIds: guardianUserIds,
      guardianDisplayNames:
          guardianUsers.map((u) => '${u.firstName} ${u.lastName}').toList(),
      documentsCount: docs.length,
      reportsCount: reports.length,
      lastHabitAt: lastHabitAt,
    );
  }
}
