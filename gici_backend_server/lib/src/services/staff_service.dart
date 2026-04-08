import 'package:serverpod/serverpod.dart';
import 'package:bcrypt/bcrypt.dart';

import '../generated/protocol.dart';

class StaffService {
  const StaffService();

  Future<List<AppUser>> listStaff(
    Session session, {
    required UuidValue organizationId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final safePage = page.clamp(0, 10000);
    final safePageSize = pageSize.clamp(1, 100);

    return await AppUser.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null) &
          (t.role.equals('staff') |
              t.role.equals('organization_admin') |
              t.role.equals('other_staff')),
      orderBy: (t) => t.lastName,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<AppUser> createStaffUser(
    Session session, {
    required UuidValue organizationId,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    String? phone,
  }) async {
    // Validate role
    if (!['staff', 'organization_admin', 'other_staff', 'guardian'].contains(role)) {
      throw Exception('Invalid role for user: $role');
    }

    // Check email uniqueness
    final existing = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email.toLowerCase()),
    );
    if (existing != null) {
      throw Exception('Email already in use.');
    }

    final passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
    final now = DateTime.now().toUtc();

    final user = AppUser(
      organizationId: organizationId,
      email: email.toLowerCase(),
      passwordHash: passwordHash,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      role: role,
      isActive: true,
      emailVerified: false,
      phoneVerified: false,
      createdAt: now,
      updatedAt: now,
    );

    return await AppUser.db.insertRow(session, user);
  }

  Future<AppUser> updateStaffUser(
    Session session, {
    required UuidValue userId,
    required UuidValue organizationId,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    bool? isActive,
  }) async {
    final user = await AppUser.db.findById(session, userId);
    if (user == null || user.organizationId != organizationId) {
      throw Exception('User not found in this organization.');
    }

    final updated = user.copyWith(
      firstName: firstName ?? user.firstName,
      lastName: lastName ?? user.lastName,
      phone: phone ?? user.phone,
      role: role ?? user.role,
      isActive: isActive ?? user.isActive,
      updatedAt: DateTime.now().toUtc(),
    );

    return await AppUser.db.updateRow(session, updated);
  }

  Future<List<AppUser>> listGuardians(
    Session session, {
    required UuidValue organizationId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final safePage = page.clamp(0, 10000);
    final safePageSize = pageSize.clamp(1, 100);

    return await AppUser.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null) &
          t.role.equals('guardian'),
      orderBy: (t) => t.lastName,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<StaffClassroomPermission> assignClassroomPermission(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required UuidValue classroomId,
    required String role,
  }) async {
    // Verify the user belongs to the organization
    final user = await AppUser.db.findById(session, userId);
    if (user == null || user.organizationId != organizationId) {
      throw Exception('User not found in this organization.');
    }

    // Check for existing permission
    final existing = await StaffClassroomPermission.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.classroomId.equals(classroomId),
    );

    if (existing != null) {
      // Update existing permission role
      final updated = existing.copyWith(
        role: role,
        updatedAt: DateTime.now().toUtc(),
      );
      return await StaffClassroomPermission.db.updateRow(session, updated);
    }

    final now = DateTime.now().toUtc();

    final permission = StaffClassroomPermission(
      organizationId: organizationId,
      userId: userId,
      classroomId: classroomId,
      role: role,
      createdAt: now,
      updatedAt: now,
    );

    return await StaffClassroomPermission.db.insertRow(session, permission);
  }

  Future<void> removeClassroomPermission(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required UuidValue classroomId,
  }) async {
    final permission = await StaffClassroomPermission.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.userId.equals(userId) &
          t.classroomId.equals(classroomId),
    );

    if (permission == null) {
      throw Exception('Permission not found.');
    }

    await StaffClassroomPermission.db.deleteRow(session, permission);
  }

  Future<List<StaffClassroomPermission>> listStaffPermissions(
    Session session, {
    required UuidValue organizationId,
    UuidValue? userId,
  }) async {
    return await StaffClassroomPermission.db.find(
      session,
      where: (t) {
        var condition = t.organizationId.equals(organizationId);
        if (userId != null) {
          condition = condition & t.userId.equals(userId);
        }
        return condition;
      },
      orderBy: (t) => t.classroomId,
    );
  }
}
