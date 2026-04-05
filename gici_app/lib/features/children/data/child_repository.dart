import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class ChildRepository {
  const ChildRepository(this._client);

  final Client _client;

  Future<List<Child>> listChildren({
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.child.listChildren(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Child> getChild({
    required UuidValue childId,
  }) {
    return _client.child.getChild(
      childId: childId,
    );
  }

  Future<Child> createChild({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) {
    return _client.child.createChild(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<Child> updateChild({
    required UuidValue childId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) {
    return _client.child.updateChild(
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
    required UuidValue childId,
  }) {
    return _client.child.getChildProfileOverview(
      childId: childId,
    );
  }
}
