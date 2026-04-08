import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/consent_service.dart';

class ConsentEndpoint extends Endpoint {
  final _accessControl = const AccessControlService();
  final _consentService = const ConsentService();
  final _activityLog = const ActivityLogService();

  /// Get all consent records for the authenticated user.
  Future<List<ConsentRecord>> getMyConsents(Session session) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    return _consentService.getMyConsents(
      session,
      organizationId: orgId,
      userId: actor.id!,
    );
  }

  /// Accept a consent of a given type, optionally for a specific child.
  Future<ConsentRecord> acceptConsent(
    Session session, {
    required String consentType,
    UuidValue? childId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    if (childId != null && actor.role == 'guardian') {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: childId,
      );
    }

    final record = await _consentService.acceptConsent(
      session,
      organizationId: orgId,
      userId: actor.id!,
      consentType: consentType,
      childId: childId,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'consent_accepted',
      entityType: 'consent_record',
      entityId: record.id?.toString(),
    );

    return record;
  }

  /// Revoke a consent of a given type, optionally for a specific child.
  Future<ConsentRecord> revokeConsent(
    Session session, {
    required String consentType,
    UuidValue? childId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    if (childId != null && actor.role == 'guardian') {
      await _accessControl.requireGuardianChildAccess(
        session,
        actor: actor,
        childId: childId,
      );
    }

    final record = await _consentService.revokeConsent(
      session,
      organizationId: orgId,
      userId: actor.id!,
      consentType: consentType,
      childId: childId,
    );

    await _activityLog.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'consent_revoked',
      entityType: 'consent_record',
      entityId: record.id?.toString(),
    );

    return record;
  }

  /// List all consent records for a specific child. Staff/admin only.
  Future<List<ConsentRecord>> listConsentsForChild(
    Session session, {
    required UuidValue childId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    return _consentService.listConsentsForChild(
      session,
      organizationId: orgId,
      childId: childId,
    );
  }
}
