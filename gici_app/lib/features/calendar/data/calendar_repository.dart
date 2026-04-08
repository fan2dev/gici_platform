import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class CalendarRepository {
  const CalendarRepository(this._client);

  final Client _client;

  Future<List<SchoolCalendarEvent>> listEvents({
    DateTime? from,
    DateTime? to,
  }) {
    return _client.calendar.listEvents(
      from: from,
      to: to,
    );
  }

  Future<SchoolCalendarEvent> createEvent({
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    bool isRecurring = false,
  }) {
    return _client.calendar.createEvent(
      title: title,
      description: description,
      eventDate: eventDate,
      endDate: endDate,
      eventType: eventType,
      isRecurring: isRecurring,
    );
  }

  Future<SchoolCalendarEvent> updateEvent({
    required UuidValue eventId,
    String? title,
    String? description,
    DateTime? eventDate,
    DateTime? endDate,
    String? eventType,
    bool? isRecurring,
  }) {
    return _client.calendar.updateEvent(
      eventId: eventId,
      title: title,
      description: description,
      eventDate: eventDate,
      endDate: endDate,
      eventType: eventType,
      isRecurring: isRecurring,
    );
  }

  Future<void> deleteEvent({
    required UuidValue eventId,
  }) {
    return _client.calendar.deleteEvent(
      eventId: eventId,
    );
  }
}
