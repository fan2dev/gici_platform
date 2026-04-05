import 'package:gici_backend_client/gici_backend_server_client.dart';

class ClassroomRepository {
  const ClassroomRepository(this._client);

  final Client _client;

  Future<List<Classroom>> listClassrooms({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.classroom.listClassrooms(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Classroom> createClassroom({
    required String organizationId,
    required String actorId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) {
    return _client.classroom.createClassroom(
      organizationId: organizationId,
      actorId: actorId,
      name: name,
      description: description,
      ageGroupMin: ageGroupMin,
      ageGroupMax: ageGroupMax,
      capacity: capacity,
      color: color,
    );
  }

  Future<Classroom> updateClassroom({
    required String organizationId,
    required String actorId,
    required int classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) {
    return _client.classroom.updateClassroom(
      organizationId: organizationId,
      actorId: actorId,
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
    required String organizationId,
    required String actorId,
    required int classroomId,
    required int childId,
  }) {
    return _client.classroom.assignChildToClassroom(
      organizationId: organizationId,
      actorId: actorId,
      classroomId: classroomId,
      childId: childId,
    );
  }

  Future<List<ClassroomAssignment>> listAssignments({
    required String organizationId,
    required String actorId,
    int? classroomId,
    int? childId,
    bool onlyActive = true,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.classroom.listAssignments(
      organizationId: organizationId,
      actorId: actorId,
      classroomId: classroomId,
      childId: childId,
      onlyActive: onlyActive,
      page: page,
      pageSize: pageSize,
    );
  }
}
