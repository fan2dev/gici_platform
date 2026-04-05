import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ClassroomService {
  const ClassroomService();

  Future<List<Classroom>> listByOrganization(
    Session session, {
    required UuidValue organizationId,
    required int limit,
    required int offset,
  }) {
    return Classroom.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.deletedAt.equals(null),
      orderBy: (t) => t.name,
      orderDescending: false,
      limit: limit,
      offset: offset,
    );
  }

  Future<Classroom> create(
    Session session, {
    required UuidValue organizationId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) {
    final now = DateTime.now().toUtc();
    return Classroom.db.insertRow(
      session,
      Classroom(
        organizationId: organizationId,
        name: name,
        description: description,
        ageGroupMin: ageGroupMin,
        ageGroupMax: ageGroupMax,
        capacity: capacity,
        color: color,
        photoUrl: null,
        status: 'active',
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<Classroom?> getById(
    Session session, {
    required UuidValue organizationId,
    required UuidValue classroomId,
  }) {
    return Classroom.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(classroomId) &
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null),
    );
  }

  Future<Classroom> update(
    Session session, {
    required Classroom classroom,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) {
    final updated = classroom.copyWith(
      name: name,
      description: description,
      ageGroupMin: ageGroupMin,
      ageGroupMax: ageGroupMax,
      capacity: capacity,
      color: color,
      status: status,
      updatedAt: DateTime.now().toUtc(),
    );
    return Classroom.db.updateRow(session, updated);
  }

  Future<ClassroomAssignment> assignChild(
    Session session, {
    required UuidValue organizationId,
    required UuidValue classroomId,
    required UuidValue childId,
    required UuidValue assignedByUserId,
  }) async {
    final now = DateTime.now().toUtc();

    final activeAssignments = await ClassroomAssignment.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId) &
          t.status.equals('active') &
          t.withdrawnAt.equals(null),
      limit: 100,
    );

    for (final assignment in activeAssignments) {
      await ClassroomAssignment.db.updateRow(
        session,
        assignment.copyWith(
          status: 'withdrawn',
          withdrawnAt: now,
          withdrawnByUserId: assignedByUserId,
          withdrawnReason: 'Reassigned to classroom $classroomId',
          updatedAt: now,
        ),
      );
    }

    return ClassroomAssignment.db.insertRow(
      session,
      ClassroomAssignment(
        organizationId: organizationId,
        classroomId: classroomId,
        childId: childId,
        assignedAt: now,
        assignedByUserId: assignedByUserId,
        withdrawnAt: null,
        withdrawnByUserId: null,
        withdrawnReason: null,
        status: 'active',
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<List<ClassroomAssignment>> listAssignments(
    Session session, {
    required UuidValue organizationId,
    UuidValue? classroomId,
    UuidValue? childId,
    bool onlyActive = true,
    required int limit,
    required int offset,
  }) {
    return ClassroomAssignment.db.find(
      session,
      where: (t) {
        var expr = t.organizationId.equals(organizationId);
        if (classroomId != null) {
          expr = expr & t.classroomId.equals(classroomId);
        }
        if (childId != null) {
          expr = expr & t.childId.equals(childId);
        }
        if (onlyActive) {
          expr = expr & t.status.equals('active') & t.withdrawnAt.equals(null);
        }
        return expr;
      },
      orderBy: (t) => t.assignedAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }
}
