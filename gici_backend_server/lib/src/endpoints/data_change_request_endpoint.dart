import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
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
    required String organizationId,
    required String actorId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    if (actor.role == 'guardian' && targetChildId != null) {
      final canAccess = await _accessControl.isGuardianOfChild(
        session,
        organizationId: orgId,
        guardianUserId: actor.id!,
        childId: targetChildId,
      );
      if (!canAccess) {
        throw Exception('Guardian cannot create request for this child.');
      }
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
      entityId: request.id,
      metadata: 'requestType=$requestType',
    );

    return request;
  }

  Future<List<DataChangeRequest>> myRequests(
    Session session, {
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 30,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

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
    required String organizationId,
    required String actorId,
    String? status,
    int page = 0,
    int pageSize = 40,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

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
    required String organizationId,
    required String actorId,
    required int requestId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

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
    required String organizationId,
    required String actorId,
    required int requestId,
    required String status,
    String? resolutionNote,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

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
      entityId: updated.id,
      metadata: 'status=$status;requestId=$requestId',
    );

    return updated;
  }
}
