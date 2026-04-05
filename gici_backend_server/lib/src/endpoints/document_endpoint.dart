import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/document_service.dart';

class DocumentEndpoint extends Endpoint {
  DocumentEndpoint();

  final _accessControl = const AccessControlService();
  final _documentService = const DocumentService();
  final _activityLogService = const ActivityLogService();

  Future<List<OrganizationDocument>> listOrganizationDocuments(
    Session session, {
    int page = 0,
    int pageSize = 30,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _documentService.listOrganizationDocuments(
      session,
      organizationId: orgId,
      guardianView: actor.role == 'guardian',
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<OrganizationDocument> createOrganizationDocument(
    Session session, {
    required String title,
    String? description,
    required String visibility,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final fileAsset = await _documentService.createFileAsset(
      session,
      organizationId: orgId,
      uploadedByUserId: actor.id!,
      originalName: originalName,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      fileType: 'organization_document',
      storagePath: storagePath,
      isPublic: false,
    );

    final doc = await _documentService.createOrganizationDocument(
      session,
      organizationId: orgId,
      createdByUserId: actor.id!,
      fileAssetId: fileAsset.id!,
      title: title,
      description: description,
      visibility: visibility,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'document.organization.create',
      entityType: 'organization_document',
      entityId: doc.id.toString(),
      metadata: 'title=$title;visibility=$visibility',
    );

    return doc;
  }

  Future<List<ChildDocument>> listChildDocuments(
    Session session, {
    required UuidValue childId,
    int page = 0,
    int pageSize = 30,
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
    final safePageSize = pageSize.clamp(1, 100);

    return _documentService.listChildDocuments(
      session,
      organizationId: orgId,
      childId: childId,
      guardianView: actor.role == 'guardian',
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<ChildDocument> createChildDocument(
    Session session, {
    required UuidValue childId,
    required String title,
    String? description,
    required bool visibleToGuardians,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final child = await Child.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(childId) &
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null),
    );
    if (child == null) {
      throw Exception('Child not found.');
    }

    final fileAsset = await _documentService.createFileAsset(
      session,
      organizationId: orgId,
      uploadedByUserId: actor.id!,
      originalName: originalName,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      fileType: 'child_document',
      storagePath: storagePath,
      isPublic: false,
    );

    final doc = await _documentService.createChildDocument(
      session,
      organizationId: orgId,
      childId: childId,
      fileAssetId: fileAsset.id!,
      createdByUserId: actor.id!,
      title: title,
      description: description,
      visibleToGuardians: visibleToGuardians,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'document.child.create',
      entityType: 'child_document',
      entityId: doc.id.toString(),
      metadata: 'childId=$childId;title=$title',
    );

    return doc;
  }

  Future<String> resolveFileDownloadUrl(
    Session session, {
    required UuidValue fileAssetId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    return _documentService.resolveFileUrl(
      session,
      organizationId: orgId,
      fileAssetId: fileAssetId,
    );
  }
}
