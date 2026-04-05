import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class AccessControlService {
  const AccessControlService();

  /// Validates that the actor has one of the allowed roles.
  /// Throws if the role is not permitted.
  void requireRole(AppUser actor, {required List<String> allowedRoles}) {
    if (!allowedRoles.contains(actor.role)) {
      throw Exception('Role ${actor.role} is not allowed for this action.');
    }
  }

  /// Validates the actor has one of the allowed roles and belongs to the
  /// given organization (unless platform_super_admin).
  void requireOrgAccess(
    AppUser actor, {
    required List<String> allowedRoles,
    UuidValue? organizationId,
  }) {
    requireRole(actor, allowedRoles: allowedRoles);

    if (actor.role != 'platform_super_admin') {
      if (actor.organizationId == null) {
        throw Exception('User has no organization.');
      }
      if (organizationId != null && actor.organizationId != organizationId) {
        throw Exception('Actor does not belong to this organization.');
      }
    }
  }

  /// Checks whether a guardian user is linked to a specific child.
  Future<bool> isGuardianOfChild(
    Session session, {
    required UuidValue organizationId,
    required UuidValue guardianUserId,
    required UuidValue childId,
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

  /// Ensures a guardian can access a specific child, throws otherwise.
  Future<void> requireGuardianChildAccess(
    Session session, {
    required AppUser actor,
    required UuidValue childId,
  }) async {
    if (actor.role == 'guardian') {
      final hasAccess = await isGuardianOfChild(
        session,
        organizationId: actor.organizationId!,
        guardianUserId: actor.id!,
        childId: childId,
      );
      if (!hasAccess) {
        throw Exception('Guardian does not have access to this child.');
      }
    }
  }
}
