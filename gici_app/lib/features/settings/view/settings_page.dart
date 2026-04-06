import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/cubit/auth_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // User profile section
              Text(
                'Perfil',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        child: Text(
                          auth.firstName != null &&
                                  auth.firstName!.isNotEmpty
                              ? auth.firstName![0].toUpperCase()
                              : '?',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        auth.displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      if (auth.email != null)
                        Text(
                          auth.email!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline,
                              ),
                        ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _roleLabel(auth.role),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Admin section
              if (auth.isAdmin) ...[
                Text(
                  'Administracion',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.business),
                        title: const Text('Ajustes de organizacion'),
                        subtitle: const Text(
                          'Configuracion general del centro',
                        ),
                        trailing:
                            const Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Ajustes de organizacion (proximamente)',
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.people),
                        title: const Text('Gestion de usuarios'),
                        subtitle: const Text(
                          'Administrar personal y familias',
                        ),
                        trailing:
                            const Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Gestion de usuarios (proximamente)',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // About section
              Text(
                'Acerca de',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('GiCi App'),
                      subtitle: Text('Version 1.0.0'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: const Text('Terminos y condiciones'),
                      trailing: const Icon(Icons.open_in_new, size: 18),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Terminos y condiciones (proximamente)',
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: const Text('Politica de privacidad'),
                      trailing: const Icon(Icons.open_in_new, size: 18),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Politica de privacidad (proximamente)',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Logout
              FilledButton.icon(
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Cerrar sesion'),
                        content: const Text(
                          'Estas seguro de que quieres cerrar sesion?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            child: const Text('Cancelar'),
                          ),
                          FilledButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            child: const Text('Cerrar sesion'),
                          ),
                        ],
                      );
                    },
                  ).then((confirmed) {
                    if (confirmed == true && context.mounted) {
                      context.read<AuthCubit>().signOut();
                    }
                  });
                },
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesion'),
                style: FilledButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.error,
                  foregroundColor:
                      Theme.of(context).colorScheme.onError,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _roleLabel(AppRole? role) {
    switch (role) {
      case AppRole.platformSuperAdmin:
        return 'Super Admin';
      case AppRole.organizationAdmin:
        return 'Administrador';
      case AppRole.staff:
        return 'Personal';
      case AppRole.guardian:
        return 'Familia';
      case null:
        return 'Sin rol';
    }
  }
}
