import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/network/backend_client.dart';

/// Bootstrap the app with the given [config].
/// Called by each flavor entry point (main_gici.dart, main_borreguet.dart).
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.current = config;
  BackendClientProvider.configure(serverUrl: config.apiUrl);

  await configureDependencies();
  runApp(const GiciApp());
}
