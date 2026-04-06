import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/child_repository.dart';

enum ChildDetailStatus { initial, loading, loaded, error }

class ChildDetailState extends Equatable {
  const ChildDetailState({
    this.status = ChildDetailStatus.initial,
    this.overview,
    this.errorMessage,
  });

  final ChildDetailStatus status;
  final ChildProfileOverview? overview;
  final String? errorMessage;

  ChildDetailState copyWith({
    ChildDetailStatus? status,
    ChildProfileOverview? overview,
    String? errorMessage,
  }) {
    return ChildDetailState(
      status: status ?? this.status,
      overview: overview ?? this.overview,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, overview, errorMessage];
}

class ChildDetailCubit extends Cubit<ChildDetailState> {
  ChildDetailCubit(this._repository) : super(const ChildDetailState());

  final ChildRepository _repository;
  UuidValue? _currentChildId;

  Future<void> loadProfile(UuidValue childId) async {
    _currentChildId = childId;
    emit(state.copyWith(status: ChildDetailStatus.loading));

    try {
      final overview = await _repository.getChildProfileOverview(
        childId: childId,
      );
      emit(state.copyWith(
        status: ChildDetailStatus.loaded,
        overview: overview,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh() async {
    if (_currentChildId == null) return;

    try {
      final overview = await _repository.getChildProfileOverview(
        childId: _currentChildId!,
      );
      emit(state.copyWith(
        status: ChildDetailStatus.loaded,
        overview: overview,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
