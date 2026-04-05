import 'package:gici_backend_client/gici_backend_server_client.dart';

class DataChangeRequestRepository {
  const DataChangeRequestRepository(this._client);

  final Client _client;

  Future<DataChangeRequest> createRequest({
    required String organizationId,
    required String actorId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
  }) {
    return _client.dataChangeRequest.createRequest(
      organizationId: organizationId,
      actorId: actorId,
      targetChildId: targetChildId,
      requestType: requestType,
      requestPayload: requestPayload,
    );
  }

  Future<List<DataChangeRequest>> myRequests({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.dataChangeRequest.myRequests(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<DataChangeRequest>> listRequestsForReview({
    required String organizationId,
    required String actorId,
    String? status,
    int page = 0,
    int pageSize = 40,
  }) {
    return _client.dataChangeRequest.listRequestsForReview(
      organizationId: organizationId,
      actorId: actorId,
      status: status,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<DataChangeRequest> getRequest({
    required String organizationId,
    required String actorId,
    required int requestId,
  }) {
    return _client.dataChangeRequest.getRequest(
      organizationId: organizationId,
      actorId: actorId,
      requestId: requestId,
    );
  }

  Future<DataChangeRequest> updateRequestStatus({
    required String organizationId,
    required String actorId,
    required int requestId,
    required String status,
    String? resolutionNote,
  }) {
    return _client.dataChangeRequest.updateRequestStatus(
      organizationId: organizationId,
      actorId: actorId,
      requestId: requestId,
      status: status,
      resolutionNote: resolutionNote,
    );
  }
}
