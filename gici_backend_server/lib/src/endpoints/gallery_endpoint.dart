import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/gallery_service.dart';

class GalleryEndpoint extends Endpoint {
  GalleryEndpoint();

  final _accessControl = const AccessControlService();
  final _galleryService = const GalleryService();
  final _activityLogService = const ActivityLogService();

  Future<List<Gallery>> listGalleries(
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

    return _galleryService.listGalleries(
      session,
      organizationId: orgId,
      actorUserId: actor.id!,
      actorRole: actor.role,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<Gallery> getGallery(
    Session session, {
    required UuidValue galleryId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final galleries = await _galleryService.listGalleries(
      session,
      organizationId: orgId,
      actorUserId: actor.id!,
      actorRole: actor.role,
      limit: 500,
      offset: 0,
    );

    final gallery = galleries.where((g) => g.id == galleryId).firstOrNull;
    if (gallery == null || gallery.organizationId != orgId) {
      throw Exception('Gallery not found.');
    }

    return gallery;
  }

  Future<Gallery> createGallery(
    Session session, {
    required String title,
    String? description,
    required String audienceType,
    UuidValue? audienceClassroomId,
    UuidValue? audienceChildId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final gallery = await _galleryService.createGallery(
      session,
      organizationId: orgId,
      createdByUserId: actor.id!,
      title: title,
      description: description,
      audienceType: audienceType,
      audienceClassroomId: audienceClassroomId,
      audienceChildId: audienceChildId,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'gallery.create',
      entityType: 'gallery',
      entityId: gallery.id.toString(),
      metadata: 'audienceType=$audienceType;title=$title',
    );

    return gallery;
  }

  Future<Gallery> updateGallery(
    Session session, {
    required UuidValue galleryId,
    String? title,
    String? description,
    String? audienceType,
    UuidValue? audienceClassroomId,
    UuidValue? audienceChildId,
    bool? isPublished,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final gallery = await Gallery.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(galleryId) &
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null),
    );
    if (gallery == null) {
      throw Exception('Gallery not found.');
    }

    final updated = await _galleryService.updateGallery(
      session,
      gallery: gallery,
      title: title,
      description: description,
      audienceType: audienceType,
      audienceClassroomId: audienceClassroomId,
      audienceChildId: audienceChildId,
      isPublished: isPublished,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'gallery.update',
      entityType: 'gallery',
      entityId: updated.id.toString(),
      metadata: 'galleryId=$galleryId',
    );

    return updated;
  }

  Future<GalleryItem> addGalleryItem(
    Session session, {
    required UuidValue galleryId,
    required UuidValue fileAssetId,
    String? caption,
    int? sortOrder,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final gallery = await Gallery.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(galleryId) &
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null),
    );
    if (gallery == null) {
      throw Exception('Gallery not found.');
    }

    final item = await _galleryService.addGalleryItem(
      session,
      organizationId: orgId,
      galleryId: galleryId,
      fileAssetId: fileAssetId,
      createdByUserId: actor.id!,
      caption: caption,
      sortOrder: sortOrder,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'gallery.item.add',
      entityType: 'gallery_item',
      entityId: item.id.toString(),
      metadata: 'galleryId=$galleryId;fileAssetId=$fileAssetId',
    );

    return item;
  }

  Future<List<GalleryItem>> listGalleryItems(
    Session session, {
    required UuidValue galleryId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    // Verify access to this gallery
    final galleries = await _galleryService.listGalleries(
      session,
      organizationId: orgId,
      actorUserId: actor.id!,
      actorRole: actor.role,
      limit: 500,
      offset: 0,
    );
    final gallery = galleries.where((g) => g.id == galleryId).firstOrNull;
    if (gallery == null) {
      throw Exception('Gallery not found.');
    }

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);

    return _galleryService.listGalleryItems(
      session,
      organizationId: orgId,
      galleryId: galleryId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }
}
