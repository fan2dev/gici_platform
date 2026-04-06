import 'package:flutter/material.dart';

/// A rounded pill badge for displaying status, category, or role.
class StatusPill extends StatelessWidget {
  const StatusPill({
    required this.label,
    this.color,
    this.icon,
    this.small = false,
    super.key,
  });

  final String label;
  final Color? color;
  final IconData? icon;
  final bool small;

  /// Common presets
  factory StatusPill.active() => const StatusPill(label: 'Activo', color: Color(0xFF43A047));
  factory StatusPill.inactive() => const StatusPill(label: 'Inactivo', color: Color(0xFFE53935));
  factory StatusPill.pending() => const StatusPill(label: 'Pendiente', color: Color(0xFFFB8C00));
  factory StatusPill.approved() => const StatusPill(label: 'Aprobado', color: Color(0xFF43A047));
  factory StatusPill.rejected() => const StatusPill(label: 'Rechazado', color: Color(0xFFE53935));

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    final fontSize = small ? 10.0 : 12.0;
    final hPad = small ? 8.0 : 12.0;
    final vPad = small ? 3.0 : 5.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize + 2, color: c),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
