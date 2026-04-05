import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class AccessControlService {
  const AccessControlService();

  Future<AppUser> requireActor(
    Session session, {
    required int actorId,
    required int organizationId,
    required List<String> allowedRoles,
  }) async {
    final actor = await AppUser.db.findById(session, actorId);
    if (actor == null || actor.deletedAt != null || !actor.isActive) {
      throw Exception('Actor not found or inactive.');
    }

    if (!allowedRoles.contains(actor.role)) {
      throw Exception('Role ${actor.role} is not allowed.');
    }

    if (actor.role != 'platform_super_admin' && actor.organizationId != organizationId) {
      throw Exception('Actor does not belong to organization $organizationId.');
    }

    return actor;
  }

  Future<bool> isGuardianOfChild(
    Session session, {
    required int organizationId,
    required int guardianUserId,
    required int childId,
  }) async {
    final relation = await ChildGuardianRelation.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.guardianUserId.equals(guardianUserId) &
          t.childId.equals(childId),
    );

    return relation != null;
  }
}
