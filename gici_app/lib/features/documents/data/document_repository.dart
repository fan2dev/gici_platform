import 'package:gici_backend_client/gici_backend_server_client.dart';

class DocumentRepository {
  const DocumentRepository(this._client);

  final Client _client;

  Future<List<OrganizationDocument>> listOrganizationDocuments({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.document.listOrganizationDocuments(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<ChildDocument>> listChildDocuments({
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.document.listChildDocuments(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<OrganizationDocument> createOrganizationDocument({
    required String organizationId,
    required String actorId,
    required String title,
    String? description,
    String visibility = 'all',
    required String originalName,
    String mimeType = 'application/octet-stream',
    required int sizeBytes,
    String? storagePath,
  }) {
    return _client.document.createOrganizationDocument(
      organizationId: organizationId,
      actorId: actorId,
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
    required String organizationId,
    required String actorId,
    required int fileAssetId,
  }) {
    return _client.document.resolveFileDownloadUrl(
      organizationId: organizationId,
      actorId: actorId,
      fileAssetId: fileAssetId,
    );
  }
}
