import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class DocumentRepository {
  const DocumentRepository(this._client);

  final Client _client;

  Future<List<OrganizationDocument>> listOrganizationDocuments({
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.document.listOrganizationDocuments(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<ChildDocument>> listChildDocuments({
    required UuidValue childId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.document.listChildDocuments(
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<OrganizationDocument> createOrganizationDocument({
    required String title,
    String? description,
    String visibility = 'all',
    required String originalName,
    String mimeType = 'application/octet-stream',
    required int sizeBytes,
    String? storagePath,
  }) {
    return _client.document.createOrganizationDocument(
      title: title,
      description: description,
      visibility: visibility,
      originalName: originalName,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      storagePath: storagePath,
    );
  }

  Future<String> resolveFileDownloadUrl({
    required UuidValue fileAssetId,
  }) {
    return _client.document.resolveFileDownloadUrl(
      fileAssetId: fileAssetId,
    );
  }
}
