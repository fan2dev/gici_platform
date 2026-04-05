import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class BackendClientProvider {
  BackendClientProvider._();

  static Client? _instance;
  static String _serverUrl = 'http://$localhost:8080/';

  /// Configure the server URL before accessing the client.
  static void configure({required String serverUrl}) {
    _serverUrl = serverUrl;
    _instance = null; // Reset if reconfigured
  }

  static Client get instance {
    _instance ??= _buildClient();
    return _instance!;
  }

  static Client _buildClient() {
    final client = Client(
      _serverUrl,
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor();

    return client;
  }
}
