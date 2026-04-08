import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class AbsenceRepository {
  const AbsenceRepository(this._client);

  final Client _client;

  Future<Absence> reportAbsence({
    required UuidValue childId,
    required DateTime date,
    required String reason,
    bool isJustified = false,
    String? notes,
  }) {
    return _client.absence.reportAbsence(
      childId: childId,
      date: date,
      reason: reason,
      isJustified: isJustified,
      notes: notes,
    );
  }

  Future<List<Absence>> listAbsencesByChild({
    required UuidValue childId,
    DateTime? from,
    DateTime? to,
  }) {
    return _client.absence.listAbsencesByChild(
      childId: childId,
      from: from,
      to: to,
    );
  }

  Future<List<Absence>> listAbsencesByDate({
    required DateTime date,
  }) {
    return _client.absence.listAbsencesByDate(
      date: date,
    );
  }

  Future<List<Absence>> listAbsencesByClassroom({
    required UuidValue classroomId,
    DateTime? from,
    DateTime? to,
  }) {
    return _client.absence.listAbsencesByClassroom(
      classroomId: classroomId,
      from: from,
      to: to,
    );
  }
}
