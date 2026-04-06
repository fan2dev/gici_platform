import 'package:flutter/material.dart';

/// A themed avatar circle with initials, gradient background, and optional badge.
class GiciAvatar extends StatelessWidget {
  const GiciAvatar({
    required this.name,
    this.radius = 22,
    this.color,
    this.badge,
    this.imageUrl,
    super.key,
  });

  final String name;
  final double radius;
  final Color? color;
  final Widget? badge;
  final String? imageUrl;

  static const _palette = [
    Color(0xFFE53935), Color(0xFF1E88E5), Color(0xFF43A047),
    Color(0xFFFB8C00), Color(0xFF8E24AA), Color(0xFF00ACC1),
    Color(0xFFD81B60), Color(0xFF3949AB), Color(0xFF7CB342),
    Color(0xFFFF6F00), Color(0xFF6D4C41), Color(0xFF546E7A),
  ];

  Color get _bgColor {
    if (color != null) return color!;
    final hash = name.isEmpty ? 0 : name.codeUnits.fold(0, (a, b) => a + b);
    return _palette[hash % _palette.length];
  }

  String get _initials {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: _bgColor.withValues(alpha: 0.15),
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              _initials,
              style: TextStyle(
                color: _bgColor,
                fontWeight: FontWeight.w700,
                fontSize: radius * 0.75,
              ),
            )
          : null,
    );

    if (badge == null) return avatar;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        Positioned(
          right: -2,
          bottom: -2,
          child: badge!,
        ),
      ],
    );
  }
}
