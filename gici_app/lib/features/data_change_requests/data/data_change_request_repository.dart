import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class DataChangeRequestRepository {
  const DataChangeRequestRepository(this._client);

  final Client _client;

  Future<DataChangeRequest> createRequest({
    UuidValue? targetChildId,
    required String requestType,
    required String requestPayload,
  }) {
    return _client.dataChangeRequest.createRequest(
      targetChildId: targetChildId,
      requestType: requestType,
      requestPayload: requestPayload,
    );
  }

  Future<List<DataChangeRequest>> myRequests({
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.dataChangeRequest.myRequests(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<DataChangeRequest>> listRequestsForReview({
    String? status,
    int page = 0,
    int pageSize = 40,
  }) {
    return _client.dataChangeRequest.listRequestsForReview(
      status: status,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<DataChangeRequest> getRequest({
    required UuidValue requestId,
  }) {
    return _client.dataChangeRequest.getRequest(
      requestId: requestId,
    );
  }

  Future<DataChangeRequest> updateRequestStatus({
    required UuidValue requestId,
    required String status,
    String? resolutionNote,
  }) {
    return _client.dataChangeRequest.updateRequestStatus(
      requestId: requestId,
      status: status,
      resolutionNote: resolutionNote,
    );
  }
}
