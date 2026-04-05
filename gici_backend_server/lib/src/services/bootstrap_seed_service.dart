import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'password_service.dart';

class BootstrapSeedService {
  const BootstrapSeedService();

  static const _passwordService = PasswordService();

  Future<void> seedElBorreguet(Session session) async {
    final now = DateTime.now().toUtc();

    var organization = await Organization.db.findFirstRow(
      session,
      where: (t) => t.slug.equals('el-borreguet') & t.deletedAt.equals(null),
    );

    organization ??= await Organization.db.insertRow(
      session,
      Organization(
        name: 'El Borreguet',
        legalName: 'El Borreguet S.L.',
        slug: 'el-borreguet',
        contactEmail: 'admin@elborreguet.demo',
        contactPhone: '+34-600-000-001',
        address: 'Carrer de Demo 10',
        city: 'Barcelona',
        postalCode: '08001',
        country: 'ES',
        taxId: 'B00000000',
        status: 'active',
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );

    final organizationId = organization.id!;

    final classrooms = await Classroom.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      limit: 1,
    );

    if (classrooms.isEmpty) {
      await Classroom.db.insert(
        session,
        [
          Classroom(
            organizationId: organizationId,
            name: 'Infants 0-1',
            description: 'Nursery room',
            ageGroupMin: 0,
            ageGroupMax: 1,
            capacity: 12,
            color: '#5DADE2',
            photoUrl: null,
            status: 'active',
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
          Classroom(
            organizationId: organizationId,
            name: 'Toddlers 1-2',
            description: 'Early toddlers room',
            ageGroupMin: 1,
            ageGroupMax: 2,
            capacity: 14,
            color: '#58D68D',
            photoUrl: null,
            status: 'active',
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
        ],
      );
    }

    final existingChildren = await Child.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      limit: 1,
    );

    if (existingChildren.isEmpty) {
      await Child.db.insert(
        session,
        [
          Child(
            organizationId: organizationId,
            firstName: 'Leo',
            lastName: 'Martinez',
            dateOfBirth: DateTime.utc(2023, 11, 14),
            gender: 'male',
            photoUrl: null,
            medicalNotes: null,
            dietaryNotes: null,
            allergies: 'None',
            emergencyContactName: 'Ana Martinez',
            emergencyContactPhone: '+34-600-111-222',
            enrollmentDate: now,
            status: 'active',
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
          Child(
            organizationId: organizationId,
            firstName: 'Mia',
            lastName: 'Soler',
            dateOfBirth: DateTime.utc(2022, 9, 2),
            gender: 'female',
            photoUrl: null,
            medicalNotes: null,
            dietaryNotes: null,
            allergies: 'Lactose',
            emergencyContactName: 'Jordi Soler',
            emergencyContactPhone: '+34-600-333-444',
            enrollmentDate: now,
            status: 'active',
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
        ],
      );
    }

    final existingUsers = await AppUser.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      limit: 1,
    );

    if (existingUsers.isEmpty) {
      final users = await AppUser.db.insert(
        session,
        [
          AppUser(
            organizationId: organizationId,
            email: 'admin@elborreguet.demo',
            passwordHash: _passwordService.hash('Admin123!'),
            firstName: 'Laura',
            lastName: 'Ribas',
            phone: '+34-600-700-001',
            avatarUrl: null,
            role: 'organization_admin',
            isActive: true,
            emailVerified: true,
            phoneVerified: true,
            lastLoginAt: null,
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
          AppUser(
            organizationId: organizationId,
            email: 'staff@elborreguet.demo',
            passwordHash: _passwordService.hash('Staff123!'),
            firstName: 'Marc',
            lastName: 'Serra',
            phone: '+34-600-700-002',
            avatarUrl: null,
            role: 'staff',
            isActive: true,
            emailVerified: true,
            phoneVerified: true,
            lastLoginAt: null,
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
          AppUser(
            organizationId: organizationId,
            email: 'guardian@elborreguet.demo',
            passwordHash: _passwordService.hash('Guardian123!'),
            firstName: 'Ana',
            lastName: 'Martinez',
            phone: '+34-600-700-003',
            avatarUrl: null,
            role: 'guardian',
            isActive: true,
            emailVerified: true,
            phoneVerified: true,
            lastLoginAt: null,
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
        ],
      );

      final adminUser = users.firstWhere(
        (u) => u.role == 'organization_admin',
      );
      final staffUser = users.firstWhere((u) => u.role == 'staff');
      final guardianUser = users.firstWhere((u) => u.role == 'guardian');

      final leoChild = await Child.db.findFirstRow(
        session,
        where: (t) =>
            t.organizationId.equals(organizationId) &
            t.firstName.equals('Leo') &
            t.lastName.equals('Martinez') &
            t.deletedAt.equals(null),
      );

      if (leoChild != null) {
        await ChildGuardianRelation.db.insertRow(
          session,
          ChildGuardianRelation(
            organizationId: organizationId,
            childId: leoChild.id!,
            guardianUserId: guardianUser.id!,
            relation: 'mother',
            isPrimary: true,
            canPickup: true,
            canViewReports: true,
            canViewPhotos: true,
            emergencyContactOrder: 1,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      await TimeEntry.db.insert(
        session,
        [
          TimeEntry(
            organizationId: organizationId,
            userId: staffUser.id!,
            entryType: 'check_in',
            recordedAt: now.subtract(const Duration(hours: 6)),
            parentEntryId: null,
            correctionReason: null,
            locationData: null,
            deviceInfo: 'seed',
            notes: 'Seed check-in',
            isManualEntry: false,
            createdByUserId: adminUser.id!,
            createdAt: now,
          ),
          TimeEntry(
            organizationId: organizationId,
            userId: staffUser.id!,
            entryType: 'check_out',
            recordedAt: now.subtract(const Duration(hours: 1)),
            parentEntryId: null,
            correctionReason: null,
            locationData: null,
            deviceInfo: 'seed',
            notes: 'Seed check-out',
            isManualEntry: false,
            createdByUserId: adminUser.id!,
            createdAt: now,
          ),
        ],
      );
    }
  }
}
