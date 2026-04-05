import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class TimeTrackingService {
  const TimeTrackingService();

  Future<TimeEntry> register(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required UuidValue createdByUserId,
    required String entryType,
    String? notes,
    UuidValue? parentEntryId,
    String? correctionReason,
  }) {
    final now = DateTime.now().toUtc();
    final row = TimeEntry(
      organizationId: organizationId,
      userId: userId,
      entryType: entryType,
      recordedAt: now,
      parentEntryId: parentEntryId,
      correctionReason: correctionReason,
      locationData: null,
      deviceInfo: null,
      notes: notes,
      isManualEntry: false,
      createdByUserId: createdByUserId,
      createdAt: now,
    );

    return TimeEntry.db.insertRow(session, row);
  }

  Future<List<TimeEntry>> myEntries(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required int limit,
    required int offset,
  }) {
    return TimeEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.userId.equals(userId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<List<TimeEntry>> listEntries(
    Session session, {
    required UuidValue organizationId,
    UuidValue? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
    required int offset,
  }) async {
    final rows = await TimeEntry.db.find(
      session,
      where: (t) {
        var expr = t.organizationId.equals(organizationId);
        if (userId != null) {
          expr = expr & t.userId.equals(userId);
        }
        return expr;
      },
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: 5000,
      offset: 0,
    );

    final filtered = rows.where((entry) {
      if (from != null && entry.recordedAt.isBefore(from)) {
        return false;
      }
      if (to != null && entry.recordedAt.isAfter(to)) {
        return false;
      }
      return true;
    }).toList();

    final start = offset.clamp(0, filtered.length);
    final end = (start + limit).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  Future<TimeEntry?> getById(
    Session session, {
    required UuidValue entryId,
  }) {
    return TimeEntry.db.findById(session, entryId);
  }

  Future<TimeEntry> createCorrection(
    Session session, {
    required UuidValue organizationId,
    required UuidValue userId,
    required UuidValue createdByUserId,
    required UuidValue parentEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) {
    return register(
      session,
      organizationId: organizationId,
      userId: userId,
      createdByUserId: createdByUserId,
      entryType: correctedEntryType,
      parentEntryId: parentEntryId,
      correctionReason: correctionReason,
      notes: notes,
    );
  }
}
