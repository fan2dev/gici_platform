import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class GalleryRepository {
  const GalleryRepository(this._client);

  final Client _client;

  Future<List<Gallery>> listGalleries({
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.gallery.listGalleries(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<List<GalleryItem>> listGalleryItems({
    required UuidValue galleryId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.gallery.listGalleryItems(
      galleryId: galleryId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Gallery> createGallery({
    required String title,
    String? description,
    String audienceType = 'organization',
    UuidValue? audienceClassroomId,
    UuidValue? audienceChildId,
  }) {
    return _client.gallery.createGallery(
      title: title,
      description: description,
      audienceType: audienceType,
      audienceClassroomId: audienceClassroomId,
      audienceChildId: audienceChildId,
    );
  }
}
