import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
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
    required String organizationId,
    required String actorId,
    required int galleryId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final galleries = await listGalleries(
      session,
      organizationId: organizationId,
      actorId: actorId,
      page: 0,
      pageSize: 500,
    );

    final gallery = galleries.where((g) => g.id == galleryId).firstOrNull;
    if (gallery == null || gallery.organizationId != orgId) {
      throw Exception('Gallery not found.');
    }

    return gallery;
  }

  Future<Gallery> createGallery(
    Session session, {
    required String organizationId,
    required String actorId,
    required String title,
    String? description,
    required String audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

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
      userId: actor.id,
      action: 'gallery.create',
      entityType: 'gallery',
      entityId: gallery.id,
      metadata: 'audienceType=$audienceType;title=$title',
    );

    return gallery;
  }

  Future<Gallery> updateGallery(
    Session session, {
    required String organizationId,
    required String actorId,
    required int galleryId,
    String? title,
    String? description,
    String? audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
    bool? isPublished,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

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
      userId: actor.id,
      action: 'gallery.update',
      entityType: 'gallery',
      entityId: updated.id,
      metadata: 'galleryId=$galleryId',
    );

    return updated;
  }

  Future<GalleryItem> addGalleryItem(
    Session session, {
    required String organizationId,
    required String actorId,
    required int galleryId,
    required int fileAssetId,
    String? caption,
    int? sortOrder,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

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
      userId: actor.id,
      action: 'gallery.item.add',
      entityType: 'gallery_item',
      entityId: item.id,
      metadata: 'galleryId=$galleryId;fileAssetId=$fileAssetId',
    );

    return item;
  }

  Future<List<GalleryItem>> listGalleryItems(
    Session session, {
    required String organizationId,
    required String actorId,
    required int galleryId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await getGallery(
      session,
      organizationId: organizationId,
      actorId: actorId,
      galleryId: galleryId,
    );

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
