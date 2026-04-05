import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class GalleryService {
  const GalleryService();

  Future<Gallery> createGallery(
    Session session, {
    required UuidValue organizationId,
    required UuidValue createdByUserId,
    required String title,
    String? description,
    required String audienceType,
    UuidValue? audienceClassroomId,
    UuidValue? audienceChildId,
  }) {
    final now = DateTime.now().toUtc();
    return Gallery.db.insertRow(
      session,
      Gallery(
        organizationId: organizationId,
        title: title,
        description: description,
        audienceType: audienceType,
        audienceClassroomId: audienceClassroomId,
        audienceChildId: audienceChildId,
        createdByUserId: createdByUserId,
        isPublished: true,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<Gallery> updateGallery(
    Session session, {
    required Gallery gallery,
    String? title,
    String? description,
    String? audienceType,
    UuidValue? audienceClassroomId,
    UuidValue? audienceChildId,
    bool? isPublished,
  }) {
    return Gallery.db.updateRow(
      session,
      gallery.copyWith(
        title: title,
        description: description,
        audienceType: audienceType,
        audienceClassroomId: audienceClassroomId,
        audienceChildId: audienceChildId,
        isPublished: isPublished,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<Gallery>> listGalleries(
    Session session, {
    required UuidValue organizationId,
    required UuidValue actorUserId,
    required String actorRole,
    required int limit,
    required int offset,
  }) async {
    final galleries = await Gallery.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null) &
          t.isPublished.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );

    if (actorRole != 'guardian') {
      return galleries;
    }

    final guardianRelations = await ChildGuardianRelation.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.guardianUserId.equals(actorUserId),
      limit: 1000,
    );
    final guardianChildIds = guardianRelations.map((r) => r.childId).toSet();

    final assignments = guardianChildIds.isEmpty
        ? const <ClassroomAssignment>[]
        : await ClassroomAssignment.db.find(
            session,
            where: (t) =>
                t.organizationId.equals(organizationId) &
                t.childId.inSet(guardianChildIds) &
                t.status.equals('active') &
                t.withdrawnAt.equals(null),
            limit: 1000,
          );
    final guardianClassroomIds = assignments.map((a) => a.classroomId).toSet();

    return galleries.where((g) {
      switch (g.audienceType) {
        case 'organization':
          return true;
        case 'child':
          return g.audienceChildId != null &&
              guardianChildIds.contains(g.audienceChildId);
        case 'classroom':
          return g.audienceClassroomId != null &&
              guardianClassroomIds.contains(g.audienceClassroomId);
        default:
          return false;
      }
    }).toList();
  }

  Future<GalleryItem> addGalleryItem(
    Session session, {
    required UuidValue organizationId,
    required UuidValue galleryId,
    required UuidValue fileAssetId,
    required UuidValue createdByUserId,
    String? caption,
    int? sortOrder,
  }) async {
    final now = DateTime.now().toUtc();

    int resolvedSortOrder = sortOrder ?? 0;
    if (sortOrder == null) {
      final existing = await GalleryItem.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(organizationId) &
            t.galleryId.equals(galleryId) &
            t.deletedAt.equals(null),
        orderBy: (t) => t.sortOrder,
        orderDescending: true,
        limit: 1,
      );
      resolvedSortOrder = existing.isEmpty ? 0 : existing.first.sortOrder + 1;
    }

    return GalleryItem.db.insertRow(
      session,
      GalleryItem(
        organizationId: organizationId,
        galleryId: galleryId,
        fileAssetId: fileAssetId,
        caption: caption,
        sortOrder: resolvedSortOrder,
        createdByUserId: createdByUserId,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<List<GalleryItem>> listGalleryItems(
    Session session, {
    required UuidValue organizationId,
    required UuidValue galleryId,
    required int limit,
    required int offset,
  }) {
    return GalleryItem.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.galleryId.equals(galleryId) &
          t.deletedAt.equals(null),
      orderBy: (t) => t.sortOrder,
      orderDescending: false,
      limit: limit,
      offset: offset,
    );
  }
}
