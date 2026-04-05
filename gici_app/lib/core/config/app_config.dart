import 'package:flutter/material.dart';

/// Application configuration that varies per flavor/tenant.
/// Each flavor (GICI, Borreguet, etc.) provides its own [AppConfig].
class AppConfig {
  const AppConfig({
    required this.appName,
    required this.bundleId,
    required this.apiUrl,
    required this.seedColor,
    this.logoAsset,
    this.darkLogoAsset,
    // this.firebaseOptions, // Added in Fase 6
  });

  final String appName;
  final String bundleId;
  final String apiUrl;
  final Color seedColor;
  final String? logoAsset;
  final String? darkLogoAsset;

  /// Global config instance, set by the flavor entry point before runApp.
  static late AppConfig current;
}
