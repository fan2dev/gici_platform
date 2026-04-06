import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/child_repository.dart';

enum ChildrenListStatus { initial, loading, loaded, error }

class ChildrenListState extends Equatable {
  const ChildrenListState({
    this.status = ChildrenListStatus.initial,
    this.children = const [],
    this.errorMessage,
  });

  final ChildrenListStatus status;
  final List<Child> children;
  final String? errorMessage;

  ChildrenListState copyWith({
    ChildrenListStatus? status,
    List<Child>? children,
    String? errorMessage,
  }) {
    return ChildrenListState(
      status: status ?? this.status,
      children: children ?? this.children,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, children, errorMessage];
}

class ChildrenListCubit extends Cubit<ChildrenListState> {
  ChildrenListCubit(this._repository) : super(const ChildrenListState());

  final ChildRepository _repository;

  Future<void> loadChildren() async {
    emit(state.copyWith(status: ChildrenListStatus.loading));

    try {
      final children = await _repository.listChildren(
        page: 0,
        pageSize: 200,
      );
      emit(state.copyWith(
        status: ChildrenListStatus.loaded,
        children: children,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildrenListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh() async {
    try {
      final children = await _repository.listChildren(
        page: 0,
        pageSize: 200,
      );
      emit(state.copyWith(
        status: ChildrenListStatus.loaded,
        children: children,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildrenListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
