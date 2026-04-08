import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../classrooms/data/classroom_repository.dart';
import '../data/child_repository.dart';

enum ChildrenListStatus { initial, loading, loaded, error }

class ChildrenListState extends Equatable {
  const ChildrenListState({
    this.status = ChildrenListStatus.initial,
    this.children = const [],
    this.classrooms = const [],
    this.classroomAssignments = const [],
    this.selectedClassroomId,
    this.errorMessage,
  });

  final ChildrenListStatus status;
  final List<Child> children;
  final List<Classroom> classrooms;
  final List<ClassroomAssignment> classroomAssignments;
  final UuidValue? selectedClassroomId;
  final String? errorMessage;

  /// Returns children filtered by the selected classroom.
  /// If [selectedClassroomId] is null, returns all children.
  List<Child> get filteredChildren {
    if (selectedClassroomId == null) return children;
    final assignedChildIds = classroomAssignments
        .where((a) => a.classroomId == selectedClassroomId)
        .map((a) => a.childId)
        .toSet();
    return children.where((c) => assignedChildIds.contains(c.id)).toList();
  }

  /// Returns the count of children assigned to a given classroom.
  int childCountForClassroom(UuidValue classroomId) {
    final assignedChildIds = classroomAssignments
        .where((a) => a.classroomId == classroomId)
        .map((a) => a.childId)
        .toSet();
    return children.where((c) => assignedChildIds.contains(c.id)).length;
  }

  ChildrenListState copyWith({
    ChildrenListStatus? status,
    List<Child>? children,
    List<Classroom>? classrooms,
    List<ClassroomAssignment>? classroomAssignments,
    UuidValue? selectedClassroomId,
    String? errorMessage,
    bool clearSelectedClassroom = false,
  }) {
    return ChildrenListState(
      status: status ?? this.status,
      children: children ?? this.children,
      classrooms: classrooms ?? this.classrooms,
      classroomAssignments:
          classroomAssignments ?? this.classroomAssignments,
      selectedClassroomId: clearSelectedClassroom
          ? null
          : (selectedClassroomId ?? this.selectedClassroomId),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        children,
        classrooms,
        classroomAssignments,
        selectedClassroomId,
        errorMessage,
      ];
}

class ChildrenListCubit extends Cubit<ChildrenListState> {
  ChildrenListCubit(this._repository, this._classroomRepository)
      : super(const ChildrenListState());

  final ChildRepository _repository;
  final ClassroomRepository _classroomRepository;

  /// Loads children, classrooms and assignments in parallel.
  Future<void> loadData() async {
    emit(state.copyWith(status: ChildrenListStatus.loading));

    try {
      final results = await Future.wait([
        _repository.listChildren(page: 0, pageSize: 200),
        _classroomRepository.listClassrooms(page: 0, pageSize: 200),
        _classroomRepository.listAssignments(
          onlyActive: true,
          page: 0,
          pageSize: 500,
        ),
      ]);

      final children = results[0] as List<Child>;
      final classrooms = results[1] as List<Classroom>;
      final assignments = results[2] as List<ClassroomAssignment>;

      // Pre-select the first classroom if available
      final selectedId =
          state.selectedClassroomId ?? classrooms.firstOrNull?.id;

      emit(state.copyWith(
        status: ChildrenListStatus.loaded,
        children: children,
        classrooms: classrooms,
        classroomAssignments: assignments,
        selectedClassroomId: selectedId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildrenListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Selects a classroom filter. Pass null to show all children.
  void selectClassroom(UuidValue? id) {
    if (id == state.selectedClassroomId) return;
    if (id == null) {
      emit(state.copyWith(clearSelectedClassroom: true));
    } else {
      emit(state.copyWith(selectedClassroomId: id));
    }
  }

  /// Legacy method -- calls [loadData].
  Future<void> loadChildren() => loadData();

  /// Creates a child and links up to two guardians.
  /// Each guardian entry is a map with keys:
  /// `firstName`, `lastName`, `email`, `phone`, `relation`.
  Future<Child> createChildWithGuardians({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? menuType,
    List<Map<String, String>> guardians = const [],
  }) async {
    final child = await _repository.createChild(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );

    for (var i = 0; i < guardians.length; i++) {
      final g = guardians[i];
      final email = g['email'];
      if (email == null || email.trim().isEmpty) continue;

      await _repository.linkGuardian(
        childId: child.id!,
        email: email.trim(),
        firstName: g['firstName'] ?? '',
        lastName: g['lastName'] ?? '',
        relation: g['relation'] ?? 'tutor',
        phone: g['phone'],
        isPrimary: i == 0,
      );
    }

    return child;
  }

  Future<void> refresh() async {
    try {
      final results = await Future.wait([
        _repository.listChildren(page: 0, pageSize: 200),
        _classroomRepository.listClassrooms(page: 0, pageSize: 200),
        _classroomRepository.listAssignments(
          onlyActive: true,
          page: 0,
          pageSize: 500,
        ),
      ]);

      final children = results[0] as List<Child>;
      final classrooms = results[1] as List<Classroom>;
      final assignments = results[2] as List<ClassroomAssignment>;

      emit(state.copyWith(
        status: ChildrenListStatus.loaded,
        children: children,
        classrooms: classrooms,
        classroomAssignments: assignments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildrenListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
