import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class CalendarService {
  const CalendarService();

  Future<List<SchoolCalendarEvent>> listEvents(
    Session session, {
    required UuidValue organizationId,
    DateTime? from,
    DateTime? to,
  }) async {
    return await SchoolCalendarEvent.db.find(
      session,
      where: (t) {
        var condition = t.organizationId.equals(organizationId) &
            t.deletedAt.equals(null);
        if (from != null) {
          condition = condition & (t.eventDate >= from);
        }
        if (to != null) {
          condition = condition & (t.eventDate <= to);
        }
        return condition;
      },
      orderBy: (t) => t.eventDate,
    );
  }

  Future<SchoolCalendarEvent> createEvent(
    Session session, {
    required UuidValue organizationId,
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    required bool isRecurring,
    required UuidValue createdByUserId,
  }) async {
    final now = DateTime.now().toUtc();

    final event = SchoolCalendarEvent(
      organizationId: organizationId,
      title: title,
      description: description,
      eventDate: eventDate,
      endDate: endDate,
      eventType: eventType,
      isRecurring: isRecurring,
      createdByUserId: createdByUserId,
      createdAt: now,
      updatedAt: now,
    );

    return await SchoolCalendarEvent.db.insertRow(session, event);
  }

  Future<SchoolCalendarEvent> updateEvent(
    Session session, {
    required UuidValue eventId,
    required UuidValue organizationId,
    String? title,
    String? description,
    DateTime? eventDate,
    DateTime? endDate,
    String? eventType,
    bool? isRecurring,
  }) async {
    final event = await SchoolCalendarEvent.db.findById(session, eventId);
    if (event == null ||
        event.organizationId != organizationId ||
        event.deletedAt != null) {
      throw Exception('Event not found in this organization.');
    }

    final updated = event.copyWith(
      title: title ?? event.title,
      description: description ?? event.description,
      eventDate: eventDate ?? event.eventDate,
      endDate: endDate ?? event.endDate,
      eventType: eventType ?? event.eventType,
      isRecurring: isRecurring ?? event.isRecurring,
      updatedAt: DateTime.now().toUtc(),
    );

    return await SchoolCalendarEvent.db.updateRow(session, updated);
  }

  Future<void> deleteEvent(
    Session session, {
    required UuidValue eventId,
    required UuidValue organizationId,
  }) async {
    final event = await SchoolCalendarEvent.db.findById(session, eventId);
    if (event == null || event.organizationId != organizationId) {
      throw Exception('Event not found in this organization.');
    }

    final deleted = event.copyWith(
      deletedAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    );

    await SchoolCalendarEvent.db.updateRow(session, deleted);
  }
}
