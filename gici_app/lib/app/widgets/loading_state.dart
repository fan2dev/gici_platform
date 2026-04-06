import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: color.withValues(alpha: 0.7),
                backgroundColor: color.withValues(alpha: 0.12),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message ?? 'Cargando...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
