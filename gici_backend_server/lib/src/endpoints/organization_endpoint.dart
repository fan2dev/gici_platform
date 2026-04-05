import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
import '../services/organization_service.dart';

class OrganizationEndpoint extends Endpoint {
  OrganizationEndpoint();

  final _organizationService = const OrganizationService();

  Future<List<Organization>> listOrganizations(
    Session session, {
    required String actorRole,
    int page = 0,
    int pageSize = 20,
  }) async {
    requireRole(actorRole, const ['platform_super_admin']);
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
    required String organizationId,
    required String actorRole,
  }) async {
    requireRole(
        actorRole, const ['platform_super_admin', 'organization_admin']);
    final orgId = int.tryParse(organizationId);
    if (orgId == null) {
      throw ArgumentError.value(
        organizationId,
        'organizationId',
        'Must be an integer organization record id',
      );
    }
    return _organizationService.getById(session, orgId);
  }

  Future<Organization> createOrganization(
    Session session, {
    required String actorRole,
    required String name,
    required String slug,
    required String contactEmail,
  }) async {
    requireRole(actorRole, const ['platform_super_admin']);
    return _organizationService.create(
      session,
      name: name,
      slug: slug,
      contactEmail: contactEmail,
    );
  }
}
