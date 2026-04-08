import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class TariffService {
  const TariffService();

  Future<List<Tariff>> listTariffs(
    Session session, {
    required UuidValue organizationId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final safePage = page.clamp(0, 10000);
    final safePageSize = pageSize.clamp(1, 100);

    return await Tariff.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null),
      orderBy: (t) => t.name,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<Tariff> createTariff(
    Session session, {
    required UuidValue organizationId,
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    required bool includesTransport,
  }) async {
    final now = DateTime.now().toUtc();

    final tariff = Tariff(
      organizationId: organizationId,
      name: name,
      description: description,
      schedule: schedule,
      monthlyPrice: monthlyPrice,
      includesTransport: includesTransport,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    return await Tariff.db.insertRow(session, tariff);
  }

  Future<Tariff> updateTariff(
    Session session, {
    required UuidValue tariffId,
    required UuidValue organizationId,
    String? name,
    String? description,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
    bool? isActive,
  }) async {
    final tariff = await Tariff.db.findById(session, tariffId);
    if (tariff == null || tariff.organizationId != organizationId) {
      throw Exception('Tariff not found in this organization.');
    }

    final updated = tariff.copyWith(
      name: name ?? tariff.name,
      description: description ?? tariff.description,
      schedule: schedule ?? tariff.schedule,
      monthlyPrice: monthlyPrice ?? tariff.monthlyPrice,
      includesTransport: includesTransport ?? tariff.includesTransport,
      isActive: isActive ?? tariff.isActive,
      updatedAt: DateTime.now().toUtc(),
    );

    return await Tariff.db.updateRow(session, updated);
  }

  Future<ChildTariffAssignment> assignTariffToChild(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
    required UuidValue tariffId,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) async {
    // Verify tariff belongs to the organization
    final tariff = await Tariff.db.findById(session, tariffId);
    if (tariff == null || tariff.organizationId != organizationId) {
      throw Exception('Tariff not found in this organization.');
    }

    final now = DateTime.now().toUtc();

    final assignment = ChildTariffAssignment(
      organizationId: organizationId,
      childId: childId,
      tariffId: tariffId,
      startDate: startDate,
      endDate: endDate,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );

    return await ChildTariffAssignment.db.insertRow(session, assignment);
  }

  Future<List<ChildTariffAssignment>> listChildTariffs(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
  }) async {
    return await ChildTariffAssignment.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId),
      orderBy: (t) => t.startDate,
    );
  }
}
