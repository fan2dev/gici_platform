import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/absence_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class AbsenceState extends Equatable {
  const AbsenceState({
    this.absences = const [],
    this.selectedDate,
    this.isLoading = false,
    this.isActing = false,
    this.errorMessage,
  });

  final List<Absence> absences;
  final DateTime? selectedDate;
  final bool isLoading;
  final bool isActing;
  final String? errorMessage;

  AbsenceState copyWith({
    List<Absence>? absences,
    DateTime? selectedDate,
    bool? isLoading,
    bool? isActing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AbsenceState(
      absences: absences ?? this.absences,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      isActing: isActing ?? this.isActing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        absences,
        selectedDate,
        isLoading,
        isActing,
        errorMessage,
      ];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class AbsenceCubit extends Cubit<AbsenceState> {
  AbsenceCubit({
    required AbsenceRepository repository,
  })  : _repo = repository,
        super(AbsenceState(selectedDate: DateTime.now()));

  final AbsenceRepository _repo;

  Future<void> loadByDate([DateTime? date]) async {
    final targetDate = date ?? state.selectedDate ?? DateTime.now();
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      selectedDate: targetDate,
    ));
    try {
      final absences = await _repo.listAbsencesByDate(date: targetDate);
      emit(state.copyWith(absences: absences, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar ausencias: $e',
      ));
    }
  }

  Future<void> loadByChild(UuidValue childId, {DateTime? from, DateTime? to}) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final absences = await _repo.listAbsencesByChild(
        childId: childId,
        from: from,
        to: to,
      );
      emit(state.copyWith(absences: absences, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar ausencias del alumno: $e',
      ));
    }
  }

  Future<void> loadByClassroom(UuidValue classroomId,
      {DateTime? from, DateTime? to}) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final absences = await _repo.listAbsencesByClassroom(
        classroomId: classroomId,
        from: from,
        to: to,
      );
      emit(state.copyWith(absences: absences, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar ausencias del aula: $e',
      ));
    }
  }

  Future<bool> report({
    required UuidValue childId,
    required DateTime date,
    required String reason,
    bool isJustified = false,
    String? notes,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.reportAbsence(
        childId: childId,
        date: date,
        reason: reason,
        isJustified: isJustified,
        notes: notes,
      );
      emit(state.copyWith(isActing: false));
      await loadByDate(state.selectedDate);
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al registrar ausencia: $e',
      ));
      return false;
    }
  }
}
