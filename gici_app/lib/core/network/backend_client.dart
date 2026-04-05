import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class BackendClientProvider {
  BackendClientProvider._();

  static final Client instance = _buildClient();

  static Client _buildClient() {
    const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
    final serverUrl = serverUrlFromEnv.isEmpty
        ? 'http://$localhost:8080/'
        : serverUrlFromEnv;

    final client = Client(serverUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor();

    return client;
  }
}
