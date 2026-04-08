import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/section_header.dart';
import '../../auth/cubit/auth_cubit.dart';

class DireccionPage extends StatelessWidget {
  const DireccionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated || !auth.isAdmin) {
      return const Scaffold(
        body: Center(child: Text('Acceso restringido a administradores.')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Direcci\u00F3n',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Gesti\u00F3n del centro',
                    icon: '\u{1F3EB}',
                  ),
                  _buildGrid(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final items = <_DireccionItem>[
      _DireccionItem(
        emoji: '\u{1F476}',
        title: 'Alta de alumnos',
        description: 'Crear nuevos alumnos y vincular tutores.',
        color: const Color(0xFF1E88E5),
        icon: Icons.person_add_rounded,
        path: '/children',
      ),
      _DireccionItem(
        emoji: '\u{1F465}',
        title: 'Personal',
        description: 'Gestionar empleados y roles del centro.',
        color: const Color(0xFF7CB342),
        icon: Icons.people_rounded,
        path: '/staff',
      ),
      _DireccionItem(
        emoji: '\u{1F3EB}',
        title: 'Aulas',
        description: 'Configurar aulas y asignaciones.',
        color: const Color(0xFF3949AB),
        icon: Icons.meeting_room_rounded,
        path: '/classrooms',
      ),
      _DireccionItem(
        emoji: '\u{1F4B0}',
        title: 'Tarifas',
        description: 'Gestionar tarifas y servicios adicionales.',
        color: const Color(0xFFFB8C00),
        icon: Icons.sell_rounded,
        path: '/tariffs',
      ),
      _DireccionItem(
        emoji: '\u{1F4CA}',
        title: 'Control horario',
        description: 'Vista de empleados, fichajes y exportaci\u00F3n.',
        color: const Color(0xFF546E7A),
        icon: Icons.access_time_rounded,
        path: '/direccion/time-tracking',
      ),
      _DireccionItem(
        emoji: '\u{1F4C5}',
        title: 'Calendario escolar',
        description: 'D\u00EDas festivos, periodos y eventos.',
        color: const Color(0xFF00ACC1),
        icon: Icons.calendar_month_rounded,
        path: '/calendar',
      ),
      _DireccionItem(
        emoji: '\u{1F512}',
        title: 'Consentimientos',
        description: 'Gestionar consentimientos y autorizaciones.',
        color: const Color(0xFF8E24AA),
        icon: Icons.shield_rounded,
        path: '/consent',
      ),
      _DireccionItem(
        emoji: '\u{1F37D}\u{FE0F}',
        title: 'Menús mensuales',
        description: 'Subir y editar menús por mes.',
        color: const Color(0xFFFB8C00),
        icon: Icons.restaurant_menu_rounded,
        path: '/menu-editor',
      ),
      _DireccionItem(
        emoji: '📋',
        title: 'Solicitudes',
        description: 'Revisar solicitudes de familias.',
        color: const Color(0xFF546E7A),
        icon: Icons.edit_note_rounded,
        path: '/requests',
      ),
      _DireccionItem(
        emoji: '🏫',
        title: 'Centro',
        description: 'Información y configuración.',
        color: const Color(0xFF26A69A),
        icon: Icons.info_rounded,
        path: '/experience',
      ),
      _DireccionItem(
        emoji: '👁️',
        title: 'Vista padres',
        description: 'Ver como ven las familias.',
        color: const Color(0xFF00897B),
        icon: Icons.visibility_rounded,
        path: '/parent-preview',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _DireccionTile(item: item);
          },
        );
      },
    );
  }
}

class _DireccionItem {
  const _DireccionItem({
    required this.emoji,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.path,
  });

  final String emoji;
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final String path;
}

class _DireccionTile extends StatelessWidget {
  const _DireccionTile({required this.item});

  final _DireccionItem item;

  @override
  Widget build(BuildContext context) {
    return GiciCard(
      margin: EdgeInsets.zero,
      onTap: () => context.go(item.path),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.color, size: 22),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
