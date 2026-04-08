import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/time_tracking_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

enum LastAction { none, checkIn, checkOut }

class TimeTrackingState extends Equatable {
  const TimeTrackingState({
    this.myEntries = const [],
    this.orgEntries = const [],
    this.lastAction = LastAction.none,
    this.lastActionTime,
    this.isLoading = false,
    this.isLoadingOrg = false,
    this.isActing = false,
    this.errorMessage,
    this.filterUserId,
    this.filterFrom,
    this.filterTo,
  });

  final List<TimeEntry> myEntries;
  final List<TimeEntry> orgEntries;
  final LastAction lastAction;
  final DateTime? lastActionTime;
  final bool isLoading;
  final bool isLoadingOrg;
  final bool isActing;
  final String? errorMessage;

  // Admin filters
  final UuidValue? filterUserId;
  final DateTime? filterFrom;
  final DateTime? filterTo;

  TimeTrackingState copyWith({
    List<TimeEntry>? myEntries,
    List<TimeEntry>? orgEntries,
    LastAction? lastAction,
    DateTime? lastActionTime,
    bool? isLoading,
    bool? isLoadingOrg,
    bool? isActing,
    String? errorMessage,
    bool clearError = false,
    UuidValue? filterUserId,
    bool clearFilterUserId = false,
    DateTime? filterFrom,
    bool clearFilterFrom = false,
    DateTime? filterTo,
    bool clearFilterTo = false,
  }) {
    return TimeTrackingState(
      myEntries: myEntries ?? this.myEntries,
      orgEntries: orgEntries ?? this.orgEntries,
      lastAction: lastAction ?? this.lastAction,
      lastActionTime: lastActionTime ?? this.lastActionTime,
      isLoading: isLoading ?? this.isLoading,
      isLoadingOrg: isLoadingOrg ?? this.isLoadingOrg,
      isActing: isActing ?? this.isActing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      filterUserId:
          clearFilterUserId ? null : (filterUserId ?? this.filterUserId),
      filterFrom: clearFilterFrom ? null : (filterFrom ?? this.filterFrom),
      filterTo: clearFilterTo ? null : (filterTo ?? this.filterTo),
    );
  }

  @override
  List<Object?> get props => [
        myEntries,
        orgEntries,
        lastAction,
        lastActionTime,
        isLoading,
        isLoadingOrg,
        isActing,
        errorMessage,
        filterUserId,
        filterFrom,
        filterTo,
      ];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class TimeTrackingCubit extends Cubit<TimeTrackingState> {
  TimeTrackingCubit({
    required TimeTrackingRepository repository,
  })  : _repo = repository,
        super(const TimeTrackingState());

  final TimeTrackingRepository _repo;

  // -- My entries -------------------------------------------------------------

  Future<void> loadMyEntries() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final entries = await _repo.myEntries(page: 0, pageSize: 200);
      // Derive last action from entries
      LastAction lastAction = LastAction.none;
      DateTime? lastActionTime;
      if (entries.isNotEmpty) {
        final latest = entries.first;
        lastAction = latest.entryType == 'check_in'
            ? LastAction.checkIn
            : LastAction.checkOut;
        lastActionTime = latest.recordedAt;
      }
      emit(state.copyWith(
        myEntries: entries,
        lastAction: lastAction,
        lastActionTime: lastActionTime,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar registros: $e',
      ));
    }
  }

  // -- Check-in / Check-out ---------------------------------------------------

  Future<void> checkIn({String? notes}) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.checkIn(notes: notes);
      emit(state.copyWith(
        isActing: false,
        lastAction: LastAction.checkIn,
        lastActionTime: DateTime.now().toUtc(),
      ));
      await loadMyEntries();
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al registrar entrada: $e',
      ));
    }
  }

  Future<void> checkOut({String? notes}) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.checkOut(notes: notes);
      emit(state.copyWith(
        isActing: false,
        lastAction: LastAction.checkOut,
        lastActionTime: DateTime.now().toUtc(),
      ));
      await loadMyEntries();
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al registrar salida: $e',
      ));
    }
  }

  // -- Org entries (admin) ----------------------------------------------------

  Future<void> loadOrgEntries({
    UuidValue? userId,
    DateTime? from,
    DateTime? to,
  }) async {
    emit(state.copyWith(
      isLoadingOrg: true,
      clearError: true,
      filterUserId: userId,
      clearFilterUserId: userId == null,
      filterFrom: from,
      clearFilterFrom: from == null,
      filterTo: to,
      clearFilterTo: to == null,
    ));
    try {
      final entries = await _repo.listEntries(
        userId: userId,
        from: from,
        to: to,
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(orgEntries: entries, isLoadingOrg: false));
    } catch (e) {
      emit(state.copyWith(
        isLoadingOrg: false,
        errorMessage: 'Error al cargar registros de organizacion: $e',
      ));
    }
  }

  // -- Corrections ------------------------------------------------------------

  Future<bool> correctEntry({
    required UuidValue targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.correctEntry(
        targetEntryId: targetEntryId,
        correctedEntryType: correctedEntryType,
        correctionReason: correctionReason,
        notes: notes,
      );
      emit(state.copyWith(isActing: false));
      // Refresh both lists
      await loadMyEntries();
      await loadOrgEntries(
        userId: state.filterUserId,
        from: state.filterFrom,
        to: state.filterTo,
      );
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al corregir registro: $e',
      ));
      return false;
    }
  }
}
