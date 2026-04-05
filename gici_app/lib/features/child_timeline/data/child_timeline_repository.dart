import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class ChildTimelineRepository {
  const ChildTimelineRepository(this._client);

  final Client _client;

  Future<List<ChildTimelineItem>> getChildTimeline({
    required UuidValue childId,
    int page = 0,
    int pageSize = 40,
  }) {
    return _client.childTimeline.getChildTimeline(
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }
}
