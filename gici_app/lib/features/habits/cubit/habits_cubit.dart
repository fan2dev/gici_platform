import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../children/data/child_repository.dart';
import '../../classrooms/data/classroom_repository.dart';
import '../data/habit_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class HabitsState extends Equatable {
  const HabitsState({
    this.classrooms = const [],
    this.selectedClassroomId,
    this.classroomChildren = const [],
    this.selectedChildId,
    this.selectedDate,
    this.dailyHabits,
    this.isLoadingClassrooms = false,
    this.isLoadingChildren = false,
    this.isLoadingHabits = false,
    this.isSaving = false,
    this.errorMessage,
  });

  final List<Classroom> classrooms;
  final UuidValue? selectedClassroomId;
  final List<Child> classroomChildren;
  final UuidValue? selectedChildId;
  final DateTime? selectedDate;
  final ChildDailyHabits? dailyHabits;
  final bool isLoadingClassrooms;
  final bool isLoadingChildren;
  final bool isLoadingHabits;
  final bool isSaving;
  final String? errorMessage;

  Classroom? get selectedClassroom {
    if (selectedClassroomId == null || classrooms.isEmpty) return null;
    try {
      return classrooms.firstWhere((c) => c.id == selectedClassroomId);
    } catch (_) {
      return classrooms.firstOrNull;
    }
  }

  Child? get selectedChild {
    if (selectedChildId == null || classroomChildren.isEmpty) return null;
    try {
      return classroomChildren.firstWhere((c) => c.id == selectedChildId);
    } catch (_) {
      return classroomChildren.firstOrNull;
    }
  }

  HabitsState copyWith({
    List<Classroom>? classrooms,
    UuidValue? selectedClassroomId,
    List<Child>? classroomChildren,
    UuidValue? selectedChildId,
    DateTime? selectedDate,
    ChildDailyHabits? dailyHabits,
    bool? isLoadingClassrooms,
    bool? isLoadingChildren,
    bool? isLoadingHabits,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
    bool clearDailyHabits = false,
    bool clearSelectedChild = false,
  }) {
    return HabitsState(
      classrooms: classrooms ?? this.classrooms,
      selectedClassroomId: selectedClassroomId ?? this.selectedClassroomId,
      classroomChildren: classroomChildren ?? this.classroomChildren,
      selectedChildId:
          clearSelectedChild ? null : (selectedChildId ?? this.selectedChildId),
      selectedDate: selectedDate ?? this.selectedDate,
      dailyHabits: clearDailyHabits ? null : (dailyHabits ?? this.dailyHabits),
      isLoadingClassrooms: isLoadingClassrooms ?? this.isLoadingClassrooms,
      isLoadingChildren: isLoadingChildren ?? this.isLoadingChildren,
      isLoadingHabits: isLoadingHabits ?? this.isLoadingHabits,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        classrooms,
        selectedClassroomId,
        classroomChildren,
        selectedChildId,
        selectedDate,
        dailyHabits,
        isLoadingClassrooms,
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
    required ClassroomRepository classroomRepository,
  })  : _habitRepo = habitRepository,
        _childRepo = childRepository,
        _classroomRepo = classroomRepository,
        super(HabitsState(selectedDate: _today()));

  final HabitRepository _habitRepo;
  final ChildRepository _childRepo;
  final ClassroomRepository _classroomRepo;

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime.utc(now.year, now.month, now.day);
  }

  // -- Classrooms -------------------------------------------------------------

  Future<void> loadClassrooms() async {
    emit(state.copyWith(isLoadingClassrooms: true, clearError: true));
    try {
      final classrooms =
          await _classroomRepo.listClassrooms(page: 0, pageSize: 200);
      final selectedId =
          state.selectedClassroomId ?? classrooms.firstOrNull?.id;
      emit(state.copyWith(
        classrooms: classrooms,
        selectedClassroomId: selectedId,
        isLoadingClassrooms: false,
      ));
      if (selectedId != null) {
        await _loadChildrenForClassroom(selectedId);
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingClassrooms: false,
        errorMessage: 'Error al cargar las aulas: $e',
      ));
    }
  }

  void selectClassroom(UuidValue classroomId) {
    if (classroomId == state.selectedClassroomId) return;
    emit(state.copyWith(
      selectedClassroomId: classroomId,
      classroomChildren: const [],
      clearSelectedChild: true,
      clearDailyHabits: true,
    ));
    _loadChildrenForClassroom(classroomId);
  }

  // -- Children ---------------------------------------------------------------

  Future<void> _loadChildrenForClassroom(UuidValue classroomId) async {
    emit(state.copyWith(isLoadingChildren: true, clearError: true));
    try {
      // Load all children and assignments for this classroom in parallel
      final results = await Future.wait([
        _childRepo.listChildren(page: 0, pageSize: 200),
        _classroomRepo.listAssignments(
          classroomId: classroomId,
          onlyActive: true,
          page: 0,
          pageSize: 200,
        ),
      ]);

      final allChildren = results[0] as List<Child>;
      final assignments = results[1] as List<ClassroomAssignment>;

      // Filter children that belong to this classroom
      final assignedChildIds =
          assignments.map((a) => a.childId).toSet();
      final filteredChildren =
          allChildren.where((c) => assignedChildIds.contains(c.id)).toList();

      emit(state.copyWith(
        classroomChildren: filteredChildren,
        isLoadingChildren: false,
        clearSelectedChild: true,
        clearDailyHabits: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingChildren: false,
        errorMessage: 'Error al cargar los alumnos: $e',
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
    if (state.selectedChildId != null) {
      loadDailyHabits();
    }
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
