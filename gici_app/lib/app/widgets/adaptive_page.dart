import 'package:flutter/material.dart';

/// A responsive page wrapper that constrains content width on wide screens
/// and provides consistent padding.
class AdaptivePage extends StatelessWidget {
  const AdaptivePage({
    required this.child,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.maxWidth = 900,
    super.key,
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: actions,
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
