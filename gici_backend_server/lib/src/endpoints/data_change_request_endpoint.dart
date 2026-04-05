import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/data_change_request_service.dart';

class DataChangeRequestEndpoint extends Endpoint {
  DataChangeRequestEndpoint();

  final _accessControl = const AccessControlService();
  final _requestService = const DataChangeRequestService();
  final _activityLogService = const ActivityLogService();

  Future<DataChangeRequest> createRequest(
    Session session, {
    UuidValue? targetChildId,
    required String requestType,
    required String requestPayload,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    if (actor.role == 'guardian' && targetChildId != null) {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: targetChildId,
      );
    }

    final request = await _requestService.create(
      session,
      organizationId: orgId,
      requesterUserId: actor.id!,
      targetChildId: targetChildId,
      requestType: requestType,
      requestPayload: requestPayload,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'data_change_request.create',
      entityType: 'data_change_request',
      entityId: request.id?.toString(),
      metadata: 'requestType=$requestType',
    );

    return request;
  }

  Future<List<DataChangeRequest>> myRequests(
    Session session, {
    int page = 0,
    int pageSize = 30,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _requestService.listOwn(
      session,
      organizationId: orgId,
      requesterUserId: actor.id!,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<List<DataChangeRequest>> listRequestsForReview(
    Session session, {
    String? status,
    int page = 0,
    int pageSize = 40,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 120);

    return _requestService.listForReview(
      session,
      organizationId: orgId,
      status: status,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<DataChangeRequest> getRequest(
    Session session, {
    required UuidValue requestId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final request = await _requestService.getById(session, requestId: requestId);
    if (request == null || request.organizationId != orgId) {
      throw Exception('Request not found.');
    }

    if (actor.role == 'guardian' && request.requesterUserId != actor.id) {
      throw Exception('Guardian can only access own requests.');
    }

    return request;
  }

  Future<DataChangeRequest> updateRequestStatus(
    Session session, {
    required UuidValue requestId,
    required String status,
    String? resolutionNote,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    if (!const ['pending', 'approved', 'rejected'].contains(status)) {
      throw Exception('Invalid status.');
    }

    final request = await _requestService.getById(session, requestId: requestId);
    if (request == null || request.organizationId != orgId) {
      throw Exception('Request not found.');
    }

    final updated = await _requestService.updateStatus(
      session,
      request: request,
      reviewedByUserId: actor.id!,
      status: status,
      resolutionNote: resolutionNote,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'data_change_request.update_status',
      entityType: 'data_change_request',
      entityId: updated.id?.toString(),
      metadata: 'status=$status;requestId=$requestId',
    );

    return updated;
  }
}
