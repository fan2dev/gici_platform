import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../children/data/child_repository.dart';
import '../data/habit_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class HabitsState extends Equatable {
  const HabitsState({
    this.children = const [],
    this.selectedChildId,
    this.selectedDate,
    this.dailyHabits,
    this.isLoadingChildren = false,
    this.isLoadingHabits = false,
    this.isSaving = false,
    this.errorMessage,
  });

  final List<Child> children;
  final UuidValue? selectedChildId;
  final DateTime? selectedDate;
  final ChildDailyHabits? dailyHabits;
  final bool isLoadingChildren;
  final bool isLoadingHabits;
  final bool isSaving;
  final String? errorMessage;

  Child? get selectedChild {
    if (selectedChildId == null || children.isEmpty) return null;
    try {
      return children.firstWhere((c) => c.id == selectedChildId);
    } catch (_) {
      return children.firstOrNull;
    }
  }

  HabitsState copyWith({
    List<Child>? children,
    UuidValue? selectedChildId,
    DateTime? selectedDate,
    ChildDailyHabits? dailyHabits,
    bool? isLoadingChildren,
    bool? isLoadingHabits,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
    bool clearDailyHabits = false,
  }) {
    return HabitsState(
      children: children ?? this.children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      selectedDate: selectedDate ?? this.selectedDate,
      dailyHabits: clearDailyHabits ? null : (dailyHabits ?? this.dailyHabits),
      isLoadingChildren: isLoadingChildren ?? this.isLoadingChildren,
      isLoadingHabits: isLoadingHabits ?? this.isLoadingHabits,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        children,
        selectedChildId,
        selectedDate,
        dailyHabits,
        isLoadingChildren,
        isLoadingHabits,
        isSaving,
        errorMessage,
      ];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class HabitsCubit extends Cubit<HabitsState> {
  HabitsCubit({
    required HabitRepository habitRepository,
    required ChildRepository childRepository,
  })  : _habitRepo = habitRepository,
        _childRepo = childRepository,
        super(HabitsState(selectedDate: _today()));

  final HabitRepository _habitRepo;
  final ChildRepository _childRepo;

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime.utc(now.year, now.month, now.day);
  }

  // -- Children ---------------------------------------------------------------

  Future<void> loadChildren() async {
    emit(state.copyWith(isLoadingChildren: true, clearError: true));
    try {
      final children = await _childRepo.listChildren(page: 0, pageSize: 200);
      final selectedId =
          state.selectedChildId ?? children.firstOrNull?.id;
      emit(state.copyWith(
        children: children,
        selectedChildId: selectedId,
        isLoadingChildren: false,
      ));
      if (selectedId != null) {
        await loadDailyHabits();
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingChildren: false,
        errorMessage: 'Error al cargar los ninos: $e',
      ));
    }
  }

  void selectChild(UuidValue childId) {
    if (childId == state.selectedChildId) return;
    emit(state.copyWith(
      selectedChildId: childId,
      clearDailyHabits: true,
    ));
    loadDailyHabits();
  }

  // -- Date -------------------------------------------------------------------

  void selectDate(DateTime date) {
    final utcDate = DateTime.utc(date.year, date.month, date.day);
    emit(state.copyWith(selectedDate: utcDate, clearDailyHabits: true));
    loadDailyHabits();
  }

  void previousDay() {
    final current = state.selectedDate ?? _today();
    selectDate(current.subtract(const Duration(days: 1)));
  }

  void nextDay() {
    final current = state.selectedDate ?? _today();
    selectDate(current.add(const Duration(days: 1)));
  }

  // -- Daily Habits -----------------------------------------------------------

  Future<void> loadDailyHabits() async {
    final childId = state.selectedChildId;
    final date = state.selectedDate ?? _today();
    if (childId == null) return;

    emit(state.copyWith(isLoadingHabits: true, clearError: true));
    try {
      final daily = await _habitRepo.getChildDailyHabits(
        childId: childId,
        day: date,
      );
      emit(state.copyWith(dailyHabits: daily, isLoadingHabits: false));
    } catch (e) {
      emit(state.copyWith(
        isLoadingHabits: false,
        errorMessage: 'Error al cargar habitos: $e',
      ));
    }
  }

  // -- Meal CRUD --------------------------------------------------------------

  Future<bool> createMeal({
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) async {
    final childId = state.selectedChildId;
    if (childId == null) return false;

    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _habitRepo.createMealEntry(
        childId: childId,
        mealType: mealType,
        consumptionLevel: consumptionLevel,
        recordedAt: recordedAt,
        menuItems: menuItems,
        notes: notes,
      );
      emit(state.copyWith(isSaving: false));
      await loadDailyHabits();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Error al crear comida: $e',
      ));
      return false;
    }
  }

  Future<bool> updateMeal({
    required UuidValue mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _habitRepo.updateMealEntry(
        mealEntryId: mealEntryId,
        mealType: mealType,
        consumptionLevel: consumptionLevel,
        recordedAt: recordedAt,
        menuItems: menuItems,
        notes: notes,
      );
      emit(state.copyWith(isSaving: false));
      await loadDailyHabits();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Error al actualizar comida: $e',
      ));
      return false;
    }
  }

  // -- Nap CRUD ---------------------------------------------------------------

  Future<bool> createNap({
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) async {
    final childId = state.selectedChildId;
    if (childId == null) return false;

    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _habitRepo.createNapEntry(
        childId: childId,
        startedAt: startedAt,
        endedAt: endedAt,
        durationMinutes: durationMinutes,
        sleepQuality: sleepQuality,
        notes: notes,
      );
      emit(state.copyWith(isSaving: false));
      await loadDailyHabits();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Error al crear siesta: $e',
      ));
      return false;
    }
  }

  Future<bool> updateNap({
    required UuidValue napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _habitRepo.updateNapEntry(
        napEntryId: napEntryId,
        startedAt: startedAt,
        endedAt: endedAt,
        durationMinutes: durationMinutes,
        sleepQuality: sleepQuality,
        notes: notes,
      );
      emit(state.copyWith(isSaving: false));
      await loadDailyHabits();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Error al actualizar siesta: $e',
      ));
      return false;
    }
  }

  // -- Bowel CRUD -------------------------------------------------------------

  Future<bool> createBowel({
    required String eventType,
    DateTime? eventAt,
    String? consistency,
    String? notes,
  }) async {
    final childId = state.selectedChildId;
    if (childId == null) return false;

    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _habitRepo.createBowelMovementEntry(
        childId: childId,
        eventType: eventType,
        eventAt: eventAt,
        consistency: consistency,
        notes: notes,
      );
      emit(state.copyWith(isSaving: false));
      await loadDailyHabits();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Error al crear deposicion: $e',
      ));
      return false;
    }
  }

  Future<bool> updateBowel({
    required UuidValue entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _habitRepo.updateBowelMovementEntry(
        entryId: entryId,
        eventAt: eventAt,
        eventType: eventType,
        consistency: consistency,
        notes: notes,
      );
      emit(state.copyWith(isSaving: false));
      await loadDailyHabits();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Error al actualizar deposicion: $e',
      ));
      return false;
    }
  }
}
