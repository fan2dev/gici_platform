import '../generated/protocol.dart';

abstract class StorageService {
  String resolveDownloadUrl(FileAsset asset);
  String normalizeStoragePath({
    required int organizationId,
    required String fileType,
    required String originalName,
  });
}

class DevelopmentStorageService implements StorageService {
  const DevelopmentStorageService();

  @override
  String resolveDownloadUrl(FileAsset asset) {
    return asset.publicUrl ?? 'local://${asset.storageBucket}/${asset.storagePath}';
  }

  @override
  String normalizeStoragePath({
    required int organizationId,
    required String fileType,
    required String originalName,
  }) {
    final safeName = originalName.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
    return '$organizationId/$fileType/$safeName';
  }
}
