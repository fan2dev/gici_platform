import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class TimeTrackingRepository {
  const TimeTrackingRepository(this._client);

  final Client _client;

  Future<TimeEntry> checkIn({
    String? notes,
  }) {
    return _client.timeTracking.checkIn(
      notes: notes,
    );
  }

  Future<TimeEntry> checkOut({
    String? notes,
  }) {
    return _client.timeTracking.checkOut(
      notes: notes,
    );
  }

  Future<List<TimeEntry>> myEntries({
    int page = 0,
    int pageSize = 20,
  }) {
    return _client.timeTracking.myEntries(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<TimeEntry>> listEntries({
    UuidValue? userId,
    DateTime? from,
    DateTime? to,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.timeTracking.listEntries(
      userId: userId,
      from: from,
      to: to,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<TimeEntry> getEntry({
    required UuidValue entryId,
  }) {
    return _client.timeTracking.getEntry(
      entryId: entryId,
    );
  }

  Future<TimeEntry> correctEntry({
    required UuidValue targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) {
    return _client.timeTracking.correctEntry(
      targetEntryId: targetEntryId,
      correctedEntryType: correctedEntryType,
      correctionReason: correctionReason,
      notes: notes,
    );
  }
}
