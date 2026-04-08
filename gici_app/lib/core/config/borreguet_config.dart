import 'package:flutter/material.dart';

import 'app_config.dart';

/// El Borreguet tenant-specific configuration.
const borreguetConfig = AppConfig(
  appName: 'El Borreguet',
  bundleId: 'com.elborreguet.app',
  apiUrl: 'http://localhost:8080/',
  seedColor: Color(0xFFCC0000),         // Ferrari red primary
  secondaryColor: Color(0xFF616161),     // Grey secondary
  accentColor: Color(0xFFFF0000),        // Bright Ferrari red accent
  surfaceColor: Color(0xFFFFF0F0),       // Warmer pink surface
  logoAsset: null,
);
