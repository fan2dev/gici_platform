import 'package:flutter/material.dart';

/// A gradient header section for pages — used at the top of detail pages, dashboards, etc.
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    required this.child,
    this.height,
    this.colors,
    super.key,
  });

  final Widget child;
  final double? height;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final effectiveColors = colors ?? [
      primary,
      primary.withValues(alpha: 0.85),
    ];

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: effectiveColors,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: child,
      ),
    );
  }
}
