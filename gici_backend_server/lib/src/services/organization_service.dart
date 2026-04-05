import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class OrganizationService {
  const OrganizationService();

  Future<Organization?> getById(Session session, int organizationId) {
    return Organization.db.findFirstRow(
      session,
      where: (t) => t.id.equals(organizationId) & t.deletedAt.equals(null),
    );
  }

  Future<List<Organization>> listActive(
    Session session, {
    required int limit,
    required int offset,
  }) {
    return Organization.db.find(
      session,
      where: (t) => t.deletedAt.equals(null),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<Organization> create(
    Session session, {
    required String name,
    required String slug,
    required String contactEmail,
  }) async {
    final row = Organization(
      name: name,
      legalName: null,
      slug: slug,
      contactEmail: contactEmail,
      contactPhone: null,
      address: null,
      city: null,
      postalCode: null,
      country: 'ES',
      taxId: null,
      status: 'active',
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
      deletedAt: null,
    );

    return Organization.db.insertRow(session, row);
  }
}
