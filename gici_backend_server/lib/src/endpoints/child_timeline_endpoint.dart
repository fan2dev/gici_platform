import 'package:serverpod/serverpod.dart';

import '../helpers/request_scope.dart';
import '../services/access_control_service.dart';
import '../services/child_timeline_service.dart';
import '../generated/protocol.dart';

class ChildTimelineEndpoint extends Endpoint {
  ChildTimelineEndpoint();

  final _accessControl = const AccessControlService();
  final _timelineService = const ChildTimelineService();

  Future<List<ChildTimelineItem>> getChildTimeline(
    Session session, {
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 40,
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

    if (actor.role == 'guardian') {
      final canAccess = await _accessControl.isGuardianOfChild(
        session,
        organizationId: orgId,
        guardianUserId: actor.id!,
        childId: childId,
      );
      if (!canAccess) {
        throw Exception('Guardian cannot access this child timeline.');
      }
    }

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 150);

    return _timelineService.buildTimeline(
      session,
      organizationId: orgId,
      childId: childId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }
}
