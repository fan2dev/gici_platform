import 'package:flutter/material.dart';

import 'app_config.dart';

/// GICI white-label generic configuration.
const giciConfig = AppConfig(
  appName: 'GICI',
  bundleId: 'com.gici.app',
  apiUrl: 'http://localhost:8080/',
  seedColor: Color(0xFFFF6D00),          // Orange primary
  secondaryColor: Color(0xFF757575),      // Grey secondary
  accentColor: Color(0xFFFF9100),         // Bright orange accent
  surfaceColor: Color(0xFFFFF5EB),        // Warmer cream surface
  logoAsset: null,
);
