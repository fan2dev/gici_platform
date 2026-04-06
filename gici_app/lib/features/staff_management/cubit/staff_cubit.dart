import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/staff_repository.dart';

enum StaffStatus { initial, loading, loaded, error }

class StaffState extends Equatable {
  const StaffState({
    this.status = StaffStatus.initial,
    this.staff = const [],
    this.guardians = const [],
    this.errorMessage,
  });

  final StaffStatus status;
  final List<AppUser> staff;
  final List<AppUser> guardians;
  final String? errorMessage;

  StaffState copyWith({
    StaffStatus? status,
    List<AppUser>? staff,
    List<AppUser>? guardians,
    String? errorMessage,
  }) {
    return StaffState(
      status: status ?? this.status,
      staff: staff ?? this.staff,
      guardians: guardians ?? this.guardians,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, staff, guardians, errorMessage];
}

class StaffCubit extends Cubit<StaffState> {
  StaffCubit(this._repository) : super(const StaffState());

  final StaffRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: StaffStatus.loading));
    try {
      final staff = await _repository.listStaff();
      final guardians = await _repository.listGuardians();
      emit(state.copyWith(
        status: StaffStatus.loaded,
        staff: staff,
        guardians: guardians,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StaffStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    String? phone,
  }) async {
    await _repository.createStaffUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      role: role,
      phone: phone,
    );
    await load();
  }

  Future<void> updateUser({
    required UuidValue userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    bool? isActive,
  }) async {
    await _repository.updateStaffUser(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      role: role,
      isActive: isActive,
    );
    await load();
  }
}
