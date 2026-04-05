import 'package:serverpod/serverpod.dart';

import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/child_timeline_service.dart';
import '../generated/protocol.dart';

class ChildTimelineEndpoint extends Endpoint {
  ChildTimelineEndpoint();

  final _accessControl = const AccessControlService();
  final _timelineService = const ChildTimelineService();

  Future<List<ChildTimelineItem>> getChildTimeline(
    Session session, {
    required UuidValue childId,
    int page = 0,
    int pageSize = 40,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    if (actor.role == 'guardian') {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: childId,
      );
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
