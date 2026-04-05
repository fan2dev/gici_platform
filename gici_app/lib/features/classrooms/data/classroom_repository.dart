import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class ClassroomRepository {
  const ClassroomRepository(this._client);

  final Client _client;

  Future<List<Classroom>> listClassrooms({
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.classroom.listClassrooms(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Classroom> createClassroom({
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) {
    return _client.classroom.createClassroom(
      name: name,
      description: description,
      ageGroupMin: ageGroupMin,
      ageGroupMax: ageGroupMax,
      capacity: capacity,
      color: color,
    );
  }

  Future<Classroom> updateClassroom({
    required UuidValue classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) {
    return _client.classroom.updateClassroom(
      classroomId: classroomId,
      name: name,
      description: description,
      ageGroupMin: ageGroupMin,
      ageGroupMax: ageGroupMax,
      capacity: capacity,
      color: color,
      status: status,
    );
  }

  Future<ClassroomAssignment> assignChildToClassroom({
    required UuidValue classroomId,
    required UuidValue childId,
  }) {
    return _client.classroom.assignChildToClassroom(
      classroomId: classroomId,
      childId: childId,
    );
  }

  Future<List<ClassroomAssignment>> listAssignments({
    UuidValue? classroomId,
    UuidValue? childId,
    bool onlyActive = true,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.classroom.listAssignments(
      classroomId: classroomId,
      childId: childId,
      onlyActive: onlyActive,
      page: page,
      pageSize: pageSize,
    );
  }
}
