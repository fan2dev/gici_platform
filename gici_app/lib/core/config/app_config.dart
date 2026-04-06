import 'package:flutter/material.dart';

/// Application configuration that varies per flavor/tenant.
class AppConfig {
  const AppConfig({
    required this.appName,
    required this.bundleId,
    required this.apiUrl,
    required this.seedColor,
    this.secondaryColor = const Color(0xFF757575),
    this.accentColor,
    this.surfaceColor = const Color(0xFFFAFAFA),
    this.logoAsset,
    this.darkLogoAsset,
  });

  final String appName;
  final String bundleId;
  final String apiUrl;
  final Color seedColor;
  final Color secondaryColor;
  final Color? accentColor;
  final Color surfaceColor;
  final String? logoAsset;
  final String? darkLogoAsset;

  Color get effectiveAccent => accentColor ?? seedColor;

  static late AppConfig current;
}
