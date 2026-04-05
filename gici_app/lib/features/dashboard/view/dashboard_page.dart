import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../auth/cubit/auth_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, auth) {
        final config = AppConfig.current;

        return Scaffold(
          appBar: AppBar(
            title: Text(config.appName),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                  context.go('/login');
                },
                icon: const Icon(Icons.logout),
                tooltip: 'Cerrar sesión',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              child: Text(
                                auth.displayName.isNotEmpty
                                    ? auth.displayName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hola, ${auth.firstName ?? ''}',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  Text(
                                    _roleLabel(auth.role),
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Quick actions grid
                    Text('Acciones rápidas',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _QuickAction(
                          icon: Icons.child_care,
                          label: 'Alumnos',
                          onTap: () => context.go('/children'),
                        ),
                        if (auth.isStaffOrAbove) ...[
                          _QuickAction(
                            icon: Icons.restaurant,
                            label: 'Hábitos',
                            onTap: () => context.go('/habits'),
                          ),
                          _QuickAction(
                            icon: Icons.meeting_room,
                            label: 'Aulas',
                            onTap: () => context.go('/classrooms'),
                          ),
                          _QuickAction(
                            icon: Icons.access_time,
                            label: 'Horario',
                            onTap: () => context.go('/time-tracking'),
                          ),
                        ],
                        _QuickAction(
                          icon: Icons.chat,
                          label: 'Chat',
                          onTap: () => context.go('/chat'),
                        ),
                        _QuickAction(
                          icon: Icons.notifications,
                          label: 'Notificaciones',
                          onTap: () => context.go('/notifications'),
                        ),
                        _QuickAction(
                          icon: Icons.description,
                          label: 'Documentos',
                          onTap: () => context.go('/documents'),
                        ),
                        _QuickAction(
                          icon: Icons.photo_library,
                          label: 'Galerías',
                          onTap: () => context.go('/galleries'),
                        ),
                        _QuickAction(
                          icon: Icons.edit_note,
                          label: auth.isGuardian
                              ? 'Mis solicitudes'
                              : 'Solicitudes',
                          onTap: () => context.go('/requests'),
                        ),
                        _QuickAction(
                          icon: Icons.info,
                          label: 'Centro',
                          onTap: () => context.go('/experience'),
                        ),
                        _QuickAction(
                          icon: Icons.settings,
                          label: 'Ajustes',
                          onTap: () => context.go('/settings'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _roleLabel(AppRole? role) {
    switch (role) {
      case AppRole.platformSuperAdmin:
        return 'Super Administrador';
      case AppRole.organizationAdmin:
        return 'Dirección';
      case AppRole.staff:
        return 'Personal';
      case AppRole.guardian:
        return 'Familia';
      case null:
        return '';
    }
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
