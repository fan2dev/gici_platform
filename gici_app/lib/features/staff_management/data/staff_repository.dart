import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class StaffRepository {
  const StaffRepository(this._client);
  final Client _client;

  Future<List<AppUser>> listStaff({int page = 0, int pageSize = 50}) {
    return _client.staff.listStaff(page: page, pageSize: pageSize);
  }

  Future<List<AppUser>> listGuardians({int page = 0, int pageSize = 50}) {
    return _client.staff.listGuardians(page: page, pageSize: pageSize);
  }

  Future<AppUser> createStaffUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    String? phone,
  }) {
    return _client.staff.createStaffUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      role: role,
      phone: phone,
    );
  }

  Future<AppUser> updateStaffUser({
    required UuidValue userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    bool? isActive,
  }) {
    return _client.staff.updateStaffUser(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      role: role,
      isActive: isActive,
    );
  }
}
