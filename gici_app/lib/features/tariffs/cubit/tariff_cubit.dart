import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/tariff_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class TariffState extends Equatable {
  const TariffState({
    this.tariffs = const [],
    this.childTariffs = const [],
    this.isLoading = false,
    this.isActing = false,
    this.errorMessage,
  });

  final List<Tariff> tariffs;
  final List<ChildTariffAssignment> childTariffs;
  final bool isLoading;
  final bool isActing;
  final String? errorMessage;

  TariffState copyWith({
    List<Tariff>? tariffs,
    List<ChildTariffAssignment>? childTariffs,
    bool? isLoading,
    bool? isActing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TariffState(
      tariffs: tariffs ?? this.tariffs,
      childTariffs: childTariffs ?? this.childTariffs,
      isLoading: isLoading ?? this.isLoading,
      isActing: isActing ?? this.isActing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        tariffs,
        childTariffs,
        isLoading,
        isActing,
        errorMessage,
      ];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class TariffCubit extends Cubit<TariffState> {
  TariffCubit({
    required TariffRepository repository,
  })  : _repo = repository,
        super(const TariffState());

  final TariffRepository _repo;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final tariffs = await _repo.listTariffs();
      emit(state.copyWith(tariffs: tariffs, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar tarifas: $e',
      ));
    }
  }

  Future<bool> create({
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    bool includesTransport = false,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.createTariff(
        name: name,
        description: description,
        schedule: schedule,
        monthlyPrice: monthlyPrice,
        includesTransport: includesTransport,
      );
      emit(state.copyWith(isActing: false));
      await load();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al crear tarifa: $e',
      ));
      return false;
    }
  }

  Future<bool> update({
    required UuidValue tariffId,
    String? name,
    String? description,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.updateTariff(
        tariffId: tariffId,
        name: name,
        description: description,
        schedule: schedule,
        monthlyPrice: monthlyPrice,
        includesTransport: includesTransport,
      );
      emit(state.copyWith(isActing: false));
      await load();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al actualizar tarifa: $e',
      ));
      return false;
    }
  }

  Future<bool> assign({
    required UuidValue tariffId,
    required UuidValue childId,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.assignTariffToChild(
        tariffId: tariffId,
        childId: childId,
        startDate: startDate,
        endDate: endDate,
        notes: notes,
      );
      emit(state.copyWith(isActing: false));
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al asignar tarifa: $e',
      ));
      return false;
    }
  }

  Future<void> loadChildTariffs(UuidValue childId) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final childTariffs = await _repo.listChildTariffs(childId: childId);
      emit(state.copyWith(childTariffs: childTariffs, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar tarifas del alumno: $e',
      ));
    }
  }
}
