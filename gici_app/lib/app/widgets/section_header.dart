import 'package:flutter/material.dart';

/// A reusable section header with title, optional icon, and optional action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.icon,
    this.action,
    this.padding,
    super.key,
  });

  final String title;
  final String? icon;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Text(icon!, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
