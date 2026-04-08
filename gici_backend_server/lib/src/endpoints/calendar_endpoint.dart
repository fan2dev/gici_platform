import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/calendar_service.dart';

class CalendarEndpoint extends Endpoint {
  final _accessControl = const AccessControlService();
  final _calendarService = const CalendarService();
  final _activityLog = const ActivityLogService();

  /// List calendar events, optionally filtered by date range.
  /// All authenticated roles can view.
  Future<List<SchoolCalendarEvent>> listEvents(
    Session session, {
    DateTime? from,
    DateTime? to,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    return _calendarService.listEvents(
      session,
      organizationId: orgId,
      from: from,
      to: to,
    );
  }

  /// Create a calendar event. Admin only.
  Future<SchoolCalendarEvent> createEvent(
    Session session, {
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    required bool isRecurring,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final event = await _calendarService.createEvent(
      session,
      organizationId: orgId,
      title: title,
      description: description,
      eventDate: eventDate,
      endDate: endDate,
      eventType: eventType,
      isRecurring: isRecurring,
      createdByUserId: actor.id!,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'calendar_event_created',
      entityType: 'school_calendar_event',
      entityId: event.id?.toString(),
    );

    return event;
  }

  /// Update a calendar event. Admin only.
  Future<SchoolCalendarEvent> updateEvent(
    Session session, {
    required UuidValue eventId,
    String? title,
    String? description,
    DateTime? eventDate,
    DateTime? endDate,
    String? eventType,
    bool? isRecurring,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    final updated = await _calendarService.updateEvent(
      session,
      eventId: eventId,
      organizationId: orgId,
      title: title,
      description: description,
      eventDate: eventDate,
      endDate: endDate,
      eventType: eventType,
      isRecurring: isRecurring,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'calendar_event_updated',
      entityType: 'school_calendar_event',
      entityId: eventId.toString(),
    );

    return updated;
  }

  /// Soft-delete a calendar event. Admin only.
  Future<void> deleteEvent(
    Session session, {
    required UuidValue eventId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    await _calendarService.deleteEvent(
      session,
      eventId: eventId,
      organizationId: orgId,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'calendar_event_deleted',
      entityType: 'school_calendar_event',
      entityId: eventId.toString(),
    );
  }
}
