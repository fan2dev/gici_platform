import 'package:gici_backend_client/gici_backend_server_client.dart';

class GalleryRepository {
  const GalleryRepository(this._client);

  final Client _client;

  Future<List<Gallery>> listGalleries({
    required String organizationId,
    required String actorId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.gallery.listGalleries(
      organizationId: organizationId,
      actorId: actorId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<GalleryItem>> listGalleryItems({
    required String organizationId,
    required String actorId,
    required int galleryId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.gallery.listGalleryItems(
      organizationId: organizationId,
      actorId: actorId,
      galleryId: galleryId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Gallery> createGallery({
    required String organizationId,
    required String actorId,
    required String title,
    String? description,
    String audienceType = 'organization',
    int? audienceClassroomId,
    int? audienceChildId,
  }) {
    return _client.gallery.createGallery(
      organizationId: organizationId,
      actorId: actorId,
      title: title,
      description: description,
      audienceType: audienceType,
      audienceClassroomId: audienceClassroomId,
      audienceChildId: audienceChildId,
    );
  }
}
