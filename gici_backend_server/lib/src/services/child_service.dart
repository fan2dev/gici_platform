import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ChildService {
  const ChildService();

  Future<List<Child>> listByOrganization(
    Session session, {
    required UuidValue organizationId,
    required int limit,
    required int offset,
  }) {
    return Child.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.deletedAt.equals(null),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<Child> create(
    Session session, {
    required UuidValue organizationId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) {
    final now = DateTime.now().toUtc();
    final row = Child(
      organizationId: organizationId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: null,
      photoUrl: null,
      medicalNotes: null,
      dietaryNotes: null,
      allergies: null,
      emergencyContactName: null,
      emergencyContactPhone: null,
      enrollmentDate: now,
      status: 'active',
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );
    return Child.db.insertRow(session, row);
  }

  Future<Child?> getById(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
  }) {
    return Child.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(childId) &
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null),
    );
  }

  Future<List<Child>> listForGuardian(
    Session session, {
    required UuidValue organizationId,
    required UuidValue guardianUserId,
    required int limit,
    required int offset,
  }) async {
    final relations = await ChildGuardianRelation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.guardianUserId.equals(guardianUserId),
      limit: 1000,
    );

    if (relations.isEmpty) {
      return const [];
    }

    final childIds = relations.map((r) => r.childId).toSet();
    return Child.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.id.inSet(childIds) &
          t.deletedAt.equals(null),
      orderBy: (t) => t.lastName,
      orderDescending: false,
      limit: limit,
      offset: offset,
    );
  }

  Future<Child> update(
    Session session, {
    required Child child,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) {
    final updated = child.copyWith(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      status: status,
      medicalNotes: medicalNotes,
      dietaryNotes: dietaryNotes,
      allergies: allergies,
      updatedAt: DateTime.now().toUtc(),
    );
    return Child.db.updateRow(session, updated);
  }
}
