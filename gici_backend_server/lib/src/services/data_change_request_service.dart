import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class DataChangeRequestService {
  const DataChangeRequestService();

  Future<DataChangeRequest> create(
    Session session, {
    required UuidValue organizationId,
    required UuidValue requesterUserId,
    UuidValue? targetChildId,
    required String requestType,
    required String requestPayload,
  }) {
    final now = DateTime.now().toUtc();
    return DataChangeRequest.db.insertRow(
      session,
      DataChangeRequest(
        organizationId: organizationId,
        requesterUserId: requesterUserId,
        targetChildId: targetChildId,
        requestType: requestType,
        requestPayload: requestPayload,
        status: 'pending',
        resolutionNote: null,
        reviewedByUserId: null,
        reviewedAt: null,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<List<DataChangeRequest>> listOwn(
    Session session, {
    required UuidValue organizationId,
    required UuidValue requesterUserId,
    required int limit,
    required int offset,
  }) {
    return DataChangeRequest.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.requesterUserId.equals(requesterUserId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<List<DataChangeRequest>> listForReview(
    Session session, {
    required UuidValue organizationId,
    String? status,
    required int limit,
    required int offset,
  }) {
    return DataChangeRequest.db.find(
      session,
      where: (t) {
        var expr = t.organizationId.equals(organizationId);
        if (status != null && status.isNotEmpty) {
          expr = expr & t.status.equals(status);
        }
        return expr;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<DataChangeRequest?> getById(
    Session session, {
    required UuidValue requestId,
  }) {
    return DataChangeRequest.db.findById(session, requestId);
  }

  Future<DataChangeRequest> updateStatus(
    Session session, {
    required DataChangeRequest request,
    required UuidValue reviewedByUserId,
    required String status,
    String? resolutionNote,
  }) {
    final now = DateTime.now().toUtc();
    return DataChangeRequest.db.updateRow(
      session,
      request.copyWith(
        status: status,
        resolutionNote: resolutionNote,
        reviewedByUserId: reviewedByUserId,
        reviewedAt: now,
        updatedAt: now,
      ),
    );
  }
}
