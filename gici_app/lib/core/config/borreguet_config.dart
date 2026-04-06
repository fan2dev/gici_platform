import 'package:flutter/material.dart';

import 'app_config.dart';

/// El Borreguet tenant-specific configuration.
const borreguetConfig = AppConfig(
  appName: 'El Borreguet',
  bundleId: 'com.elborreguet.app',
  apiUrl: 'http://localhost:8080/',
  seedColor: Color(0xFFD32F2F),         // Red primary
  secondaryColor: Color(0xFF616161),     // Grey secondary
  accentColor: Color(0xFFFF5252),        // Bright red accent
  surfaceColor: Color(0xFFFAFAFA),       // Light grey surface
  logoAsset: null,
);
