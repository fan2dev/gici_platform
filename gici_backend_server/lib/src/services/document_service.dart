import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'storage_service.dart';

class DocumentService {
  const DocumentService({StorageService storageService = const DevelopmentStorageService()})
      : _storageService = storageService;

  final StorageService _storageService;

  Future<FileAsset> createFileAsset(
    Session session, {
    required int organizationId,
    required int uploadedByUserId,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required String fileType,
    String? storagePath,
    bool isPublic = false,
  }) {
    final now = DateTime.now().toUtc();
    final normalizedPath = storagePath ??
        _storageService.normalizeStoragePath(
          organizationId: organizationId,
          fileType: fileType,
          originalName: originalName,
        );

    return FileAsset.db.insertRow(
      session,
      FileAsset(
        organizationId: organizationId,
        uploadedByUserId: uploadedByUserId,
        fileName: normalizedPath.split('/').last,
        originalName: originalName,
        mimeType: mimeType,
        sizeBytes: sizeBytes,
        storageProvider: 'development_local',
        storageBucket: 'gici-local',
        storagePath: normalizedPath,
        publicUrl: null,
        thumbnailUrl: null,
        fileType: fileType,
        isPublic: isPublic,
        expiresAt: null,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<List<OrganizationDocument>> listOrganizationDocuments(
    Session session, {
    required int organizationId,
    required bool guardianView,
    required int limit,
    required int offset,
  }) {
    return OrganizationDocument.db.find(
      session,
      where: (t) {
        var expr =
            t.organizationId.equals(organizationId) & t.deletedAt.equals(null);
        if (guardianView) {
          expr = expr & (t.visibility.equals('guardian') | t.visibility.equals('all'));
        }
        return expr;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<OrganizationDocument> createOrganizationDocument(
    Session session, {
    required int organizationId,
    required int createdByUserId,
    required int fileAssetId,
    required String title,
    String? description,
    required String visibility,
  }) {
    final now = DateTime.now().toUtc();
    return OrganizationDocument.db.insertRow(
      session,
      OrganizationDocument(
        organizationId: organizationId,
        fileAssetId: fileAssetId,
        title: title,
        description: description,
        visibility: visibility,
        createdByUserId: createdByUserId,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<List<ChildDocument>> listChildDocuments(
    Session session, {
    required int organizationId,
    required int childId,
    required bool guardianView,
    required int limit,
    required int offset,
  }) {
    return ChildDocument.db.find(
      session,
      where: (t) {
        var expr =
            t.organizationId.equals(organizationId) &
            t.childId.equals(childId) &
            t.deletedAt.equals(null);
        if (guardianView) {
          expr = expr & t.visibleToGuardians.equals(true);
        }
        return expr;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<ChildDocument> createChildDocument(
    Session session, {
    required int organizationId,
    required int childId,
    required int fileAssetId,
    required int createdByUserId,
    required String title,
    String? description,
    required bool visibleToGuardians,
  }) {
    final now = DateTime.now().toUtc();
    return ChildDocument.db.insertRow(
      session,
      ChildDocument(
        organizationId: organizationId,
        childId: childId,
        fileAssetId: fileAssetId,
        title: title,
        description: description,
        visibleToGuardians: visibleToGuardians,
        createdByUserId: createdByUserId,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<String> resolveFileUrl(
    Session session, {
    required int organizationId,
    required int fileAssetId,
  }) async {
    final asset = await FileAsset.db.findById(session, fileAssetId);
    if (asset == null || asset.organizationId != organizationId || asset.deletedAt != null) {
      throw Exception('File asset not found.');
    }
    return _storageService.resolveDownloadUrl(asset);
  }
}
