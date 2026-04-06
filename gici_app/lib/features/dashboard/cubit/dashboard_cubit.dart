import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/dashboard_repository.dart';

// ── State ────────────────────────────────────────────────────────────────

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.initial,
    this.summary,
    this.errorMessage,
  });

  final DashboardStatus status;
  final DashboardSummary? summary;
  final String? errorMessage;

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardSummary? summary,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, summary, errorMessage];
}

// ── Cubit ────────────────────────────────────────────────────────────────

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._repository) : super(const DashboardState());

  final DashboardRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      final summary = await _repository.getSummary();
      emit(state.copyWith(status: DashboardStatus.loaded, summary: summary));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.error,
        errorMessage: 'No se pudo cargar el resumen. Inténtalo de nuevo.',
      ));
    }
  }
}
