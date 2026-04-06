import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/classroom_repository.dart';

enum ClassroomsStatus { initial, loading, loaded, error }

class ClassroomsState extends Equatable {
  const ClassroomsState({
    this.status = ClassroomsStatus.initial,
    this.classrooms = const [],
    this.assignments = const [],
    this.errorMessage,
  });

  final ClassroomsStatus status;
  final List<Classroom> classrooms;
  final List<ClassroomAssignment> assignments;
  final String? errorMessage;

  ClassroomsState copyWith({
    ClassroomsStatus? status,
    List<Classroom>? classrooms,
    List<ClassroomAssignment>? assignments,
    String? errorMessage,
  }) {
    return ClassroomsState(
      status: status ?? this.status,
      classrooms: classrooms ?? this.classrooms,
      assignments: assignments ?? this.assignments,
      errorMessage: errorMessage,
    );
  }

  List<ClassroomAssignment> assignmentsFor(UuidValue classroomId) {
    return assignments
        .where((a) => a.classroomId == classroomId)
        .toList();
  }

  @override
  List<Object?> get props => [status, classrooms, assignments, errorMessage];
}

class ClassroomsCubit extends Cubit<ClassroomsState> {
  ClassroomsCubit(this._repository) : super(const ClassroomsState());

  final ClassroomRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: ClassroomsStatus.loading));

    try {
      final classrooms = await _repository.listClassrooms(
        page: 0,
        pageSize: 100,
      );
      final assignments = await _repository.listAssignments(
        onlyActive: true,
        page: 0,
        pageSize: 500,
      );
      emit(state.copyWith(
        status: ClassroomsStatus.loaded,
        classrooms: classrooms,
        assignments: assignments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ClassroomsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createClassroom({
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) async {
    try {
      await _repository.createClassroom(
        name: name,
        description: description,
        ageGroupMin: ageGroupMin,
        ageGroupMax: ageGroupMax,
        capacity: capacity,
        color: color,
      );
      await load();
    } catch (e) {
      emit(state.copyWith(
        status: ClassroomsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> assignChild({
    required UuidValue classroomId,
    required UuidValue childId,
  }) async {
    try {
      await _repository.assignChildToClassroom(
        classroomId: classroomId,
        childId: childId,
      );
      await load();
    } catch (e) {
      emit(state.copyWith(
        status: ClassroomsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateClassroom({
    required UuidValue classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) async {
    try {
      await _repository.updateClassroom(
        classroomId: classroomId,
        name: name,
        description: description,
        ageGroupMin: ageGroupMin,
        ageGroupMax: ageGroupMax,
        capacity: capacity,
        color: color,
        status: status,
      );
      await load();
    } catch (e) {
      emit(state.copyWith(
        status: ClassroomsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
