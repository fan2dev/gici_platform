import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/data_change_request_repository.dart';

enum DataChangeRequestsStatus { initial, loading, loaded, error }

class DataChangeRequestsState extends Equatable {
  const DataChangeRequestsState({
    this.status = DataChangeRequestsStatus.initial,
    this.requests = const [],
    this.errorMessage,
  });

  final DataChangeRequestsStatus status;
  final List<DataChangeRequest> requests;
  final String? errorMessage;

  int get pendingCount =>
      requests.where((r) => r.status == 'pending').length;

  DataChangeRequestsState copyWith({
    DataChangeRequestsStatus? status,
    List<DataChangeRequest>? requests,
    String? errorMessage,
  }) {
    return DataChangeRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage];
}

class DataChangeRequestsCubit extends Cubit<DataChangeRequestsState> {
  DataChangeRequestsCubit(this._repository)
      : super(const DataChangeRequestsState());

  final DataChangeRequestRepository _repository;

  Future<void> loadMyRequests() async {
    emit(state.copyWith(status: DataChangeRequestsStatus.loading));

    try {
      final requests = await _repository.myRequests(
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: DataChangeRequestsStatus.loaded,
        requests: requests,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DataChangeRequestsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadForReview() async {
    emit(state.copyWith(status: DataChangeRequestsStatus.loading));

    try {
      final requests = await _repository.listRequestsForReview(
        page: 0,
        pageSize: 100,
      );
      emit(state.copyWith(
        status: DataChangeRequestsStatus.loaded,
        requests: requests,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DataChangeRequestsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createRequest({
    UuidValue? targetChildId,
    required String requestType,
    required String requestPayload,
  }) async {
    try {
      await _repository.createRequest(
        targetChildId: targetChildId,
        requestType: requestType,
        requestPayload: requestPayload,
      );
      await loadMyRequests();
    } catch (e) {
      emit(state.copyWith(
        status: DataChangeRequestsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateStatus({
    required UuidValue requestId,
    required String status,
    String? resolutionNote,
  }) async {
    try {
      await _repository.updateRequestStatus(
        requestId: requestId,
        status: status,
        resolutionNote: resolutionNote,
      );
      await loadForReview();
    } catch (e) {
      emit(state.copyWith(
        status: DataChangeRequestsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
