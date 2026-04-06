import 'package:gici_backend_client/gici_backend_server_client.dart';

class DashboardRepository {
  const DashboardRepository(this._client);

  final Client _client;

  Future<DashboardSummary> getSummary() async {
    return _client.dashboard.getSummary();
  }
}
