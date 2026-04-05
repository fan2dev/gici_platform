import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/organization_service.dart';

class OrganizationEndpoint extends Endpoint {
  OrganizationEndpoint();

  final _accessControl = const AccessControlService();
  final _organizationService = const OrganizationService();

  Future<List<Organization>> listOrganizations(
    Session session, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const ['platform_super_admin']);

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _organizationService.listActive(
      session,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<Organization?> getOrganization(
    Session session, {
    required UuidValue organizationId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(
      actor,
      allowedRoles: const ['platform_super_admin', 'organization_admin'],
    );

    return _organizationService.getById(session, organizationId);
  }

  Future<Organization> createOrganization(
    Session session, {
    required String name,
    required String slug,
    required String contactEmail,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const ['platform_super_admin']);

    return _organizationService.create(
      session,
      name: name,
      slug: slug,
      contactEmail: contactEmail,
    );
  }
}
