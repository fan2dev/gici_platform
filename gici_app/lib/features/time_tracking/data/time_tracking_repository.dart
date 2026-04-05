import 'package:gici_backend_client/gici_backend_server_client.dart';

class TimeTrackingRepository {
  const TimeTrackingRepository(this._client);

  final Client _client;

  Future<TimeEntry> checkIn({
    required String organizationId,
    required String actorId,
    String? notes,
  }) {
    return _client.timeTracking.checkIn(
      organizationId: organizationId,
      actorId: actorId,
      notes: notes,
    );
  }

  Future<TimeEntry> checkOut({
    required String organizationId,
    required String actorId,
    String? notes,
  }) {
    return _client.timeTracking.checkOut(
      organizationId: organizationId,
      actorId: actorId,
      notes: notes,
    );
  }

  Future<List<TimeEntry>> myEntries({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 20,
  }) {
    return _client.timeTracking.myEntries(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<TimeEntry>> listEntries({
    required String organizationId,
    required String actorId,
    String? userId,
    DateTime? from,
    DateTime? to,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.timeTracking.listEntries(
      organizationId: organizationId,
      actorId: actorId,
      userId: userId,
      from: from,
      to: to,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<TimeEntry> getEntry({
    required String organizationId,
    required String actorId,
    required int entryId,
  }) {
    return _client.timeTracking.getEntry(
      organizationId: organizationId,
      actorId: actorId,
      entryId: entryId,
    );
  }

  Future<TimeEntry> correctEntry({
    required String organizationId,
    required String actorId,
    required int targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) {
    return _client.timeTracking.correctEntry(
      organizationId: organizationId,
      actorId: actorId,
      targetEntryId: targetEntryId,
      correctedEntryType: correctedEntryType,
      correctionReason: correctionReason,
      notes: notes,
    );
  }
}
