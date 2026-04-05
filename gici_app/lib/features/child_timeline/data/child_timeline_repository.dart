import 'package:gici_backend_client/gici_backend_server_client.dart';

class ChildTimelineRepository {
  const ChildTimelineRepository(this._client);

  final Client _client;

  Future<List<ChildTimelineItem>> getChildTimeline({
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 40,
  }) {
    return _client.childTimeline.getChildTimeline(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }
}
