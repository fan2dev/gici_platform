import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/calendar_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class CalendarState extends Equatable {
  const CalendarState({
    this.events = const [],
    this.selectedMonth,
    this.isLoading = false,
    this.isActing = false,
    this.errorMessage,
  });

  final List<SchoolCalendarEvent> events;
  final DateTime? selectedMonth;
  final bool isLoading;
  final bool isActing;
  final String? errorMessage;

  CalendarState copyWith({
    List<SchoolCalendarEvent>? events,
    DateTime? selectedMonth,
    bool? isLoading,
    bool? isActing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CalendarState(
      events: events ?? this.events,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      isLoading: isLoading ?? this.isLoading,
      isActing: isActing ?? this.isActing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        events,
        selectedMonth,
        isLoading,
        isActing,
        errorMessage,
      ];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({
    required CalendarRepository repository,
  })  : _repo = repository,
        super(CalendarState(selectedMonth: DateTime.now()));

  final CalendarRepository _repo;

  Future<void> loadMonth([DateTime? month]) async {
    final target = month ?? state.selectedMonth ?? DateTime.now();
    final from = DateTime(target.year, target.month, 1);
    final to = DateTime(target.year, target.month + 1, 0, 23, 59, 59);

    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      selectedMonth: from,
    ));
    try {
      final events = await _repo.listEvents(from: from, to: to);
      emit(state.copyWith(events: events, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar eventos: $e',
      ));
    }
  }

  Future<bool> create({
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    bool isRecurring = false,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.createEvent(
        title: title,
        description: description,
        eventDate: eventDate,
        endDate: endDate,
        eventType: eventType,
        isRecurring: isRecurring,
      );
      emit(state.copyWith(isActing: false));
      await loadMonth(state.selectedMonth);
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al crear evento: $e',
      ));
      return false;
    }
  }

  Future<bool> update({
    required UuidValue eventId,
    String? title,
    String? description,
    DateTime? eventDate,
    DateTime? endDate,
    String? eventType,
    bool? isRecurring,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.updateEvent(
        eventId: eventId,
        title: title,
        description: description,
        eventDate: eventDate,
        endDate: endDate,
        eventType: eventType,
        isRecurring: isRecurring,
      );
      emit(state.copyWith(isActing: false));
      await loadMonth(state.selectedMonth);
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al actualizar evento: $e',
      ));
      return false;
    }
  }

  Future<bool> delete(UuidValue eventId) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.deleteEvent(eventId: eventId);
      emit(state.copyWith(isActing: false));
      await loadMonth(state.selectedMonth);
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al eliminar evento: $e',
      ));
      return false;
    }
  }
}
