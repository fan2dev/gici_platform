import 'package:gici_backend_client/gici_backend_server_client.dart';

class ChildRepository {
  const ChildRepository(this._client);

  final Client _client;

  Future<List<Child>> listChildren({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.child.listChildren(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Child> getChild({
    required String organizationId,
    required String actorId,
    required int childId,
  }) {
    return _client.child.getChild(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
    );
  }

  Future<Child> createChild({
    required String organizationId,
    required String actorId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) {
    return _client.child.createChild(
      organizationId: organizationId,
      actorId: actorId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<Child> updateChild({
    required String organizationId,
    required String actorId,
    required int childId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) {
    return _client.child.updateChild(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      status: status,
      medicalNotes: medicalNotes,
      dietaryNotes: dietaryNotes,
      allergies: allergies,
    );
  }

  Future<ChildProfileOverview> getChildProfileOverview({
    required String organizationId,
    required String actorId,
    required int childId,
  }) {
    return _client.child.getChildProfileOverview(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
    );
  }
}
