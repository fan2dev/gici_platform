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
              t.role.equals('organization_admin')),
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
    if (!['staff', 'organization_admin'].contains(role)) {
      throw Exception('Invalid role for staff user: $role');
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
}
