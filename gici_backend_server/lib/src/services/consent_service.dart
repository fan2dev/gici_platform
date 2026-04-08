import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ConsentService {
  const ConsentService();

  Future<List<ConsentRecord>> getMyConsents(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
  }) async {
    return await ConsentRecord.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.userId.equals(userId),
      orderBy: (t) => t.consentType,
    );
  }

  Future<ConsentRecord> acceptConsent(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required String consentType,
    UuidValue? childId,
    String? ipAddress,
  }) async {
    // Check if a record already exists for this user/type/child combination
    final existing = await ConsentRecord.db.findFirstRow(
      session,
      where: (t) {
        var condition = t.organizationId.equals(organizationId) &
            t.userId.equals(userId) &
            t.consentType.equals(consentType);
        if (childId != null) {
          condition = condition & t.childId.equals(childId);
        } else {
          condition = condition & t.childId.equals(null);
        }
        return condition;
      },
    );

    final now = DateTime.now().toUtc();

    if (existing != null) {
      final updated = existing.copyWith(
        isAccepted: true,
        acceptedAt: now,
        ipAddress: ipAddress,
        updatedAt: now,
      );
      return await ConsentRecord.db.updateRow(session, updated);
    }

    final record = ConsentRecord(
      organizationId: organizationId,
      userId: userId,
      childId: childId,
      consentType: consentType,
      isAccepted: true,
      acceptedAt: now,
      ipAddress: ipAddress,
      createdAt: now,
      updatedAt: now,
    );

    return await ConsentRecord.db.insertRow(session, record);
  }

  Future<ConsentRecord> revokeConsent(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required String consentType,
    UuidValue? childId,
  }) async {
    final existing = await ConsentRecord.db.findFirstRow(
      session,
      where: (t) {
        var condition = t.organizationId.equals(organizationId) &
            t.userId.equals(userId) &
            t.consentType.equals(consentType);
        if (childId != null) {
          condition = condition & t.childId.equals(childId);
        } else {
          condition = condition & t.childId.equals(null);
        }
        return condition;
      },
    );

    if (existing == null) {
      throw Exception('Consent record not found.');
    }

    final updated = existing.copyWith(
      isAccepted: false,
      updatedAt: DateTime.now().toUtc(),
    );

    return await ConsentRecord.db.updateRow(session, updated);
  }

  Future<List<ConsentRecord>> listConsentsForChild(
    Session session, {
    required UuidValue organizationId,
    required UuidValue childId,
  }) async {
    return await ConsentRecord.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId),
      orderBy: (t) => t.consentType,
    );
  }
}
