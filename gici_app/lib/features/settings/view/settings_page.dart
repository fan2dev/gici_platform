import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/gradient_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../auth/cubit/auth_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: CustomScrollView(
        slivers: [
          // Gradient header with profile
          SliverToBoxAdapter(
            child: GradientHeader(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  children: [
                    // Top bar
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/dashboard'),
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white),
                        ),
                        const Expanded(
                          child: Text(
                            'Ajustes',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Profile info
                    GiciAvatar(
                      name: auth.displayName,
                      radius: 36,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      auth.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    if (auth.email != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        auth.email!,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    StatusPill(
                      label: _roleLabel(auth.role),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                auth.isGuardian
                    ? _buildGuardianSettings(context, auth)
                    : _buildStaffSettings(context, auth),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Staff / Admin settings
  // ---------------------------------------------------------------------------

  List<Widget> _buildStaffSettings(BuildContext context, AuthState auth) {
    return [
      // Mi cuenta
      _sectionLabel('Mi cuenta'),
      GiciCard(
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.lock_outline,
              iconBg: const Color(0xFFE3F2FD),
              iconColor: const Color(0xFF42A5F5),
              title: 'Cambiar contrasena',
              onTap: () => _showComingSoon(context),
            ),
            const Divider(height: 1),
            _SettingsTile(
              icon: Icons.notifications_outlined,
              iconBg: const Color(0xFFFFF3E0),
              iconColor: const Color(0xFFFFA726),
              title: 'Notificaciones',
              onTap: () => _showComingSoon(context),
            ),
          ],
        ),
      ),

      // Datos y privacidad
      const SizedBox(height: 8),
      _sectionLabel('Datos y privacidad'),
      GiciCard(
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.verified_user_outlined,
              iconBg: const Color(0xFFE8F5E9),
              iconColor: const Color(0xFF66BB6A),
              title: 'Consentimientos',
              onTap: () => context.go('/consent'),
            ),
          ],
        ),
      ),

      // Acerca de
      const SizedBox(height: 8),
      _sectionLabel('Acerca de'),
      GiciCard(
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.info_outline_rounded,
              iconBg: Colors.grey.shade100,
              iconColor: Colors.grey.shade600,
              title: 'GiCi App',
              subtitle: 'Version 1.0.0',
              showChevron: false,
            ),
            const Divider(height: 1),
            _SettingsTile(
              icon: Icons.privacy_tip_outlined,
              iconBg: const Color(0xFFE3F2FD),
              iconColor: const Color(0xFF42A5F5),
              title: 'Politica de privacidad',
              onTap: () => _showComingSoon(context),
            ),
            const Divider(height: 1),
            _SettingsTile(
              icon: Icons.description_outlined,
              iconBg: const Color(0xFFFFF3E0),
              iconColor: const Color(0xFFFFA726),
              title: 'Terminos y condiciones',
              onTap: () => _showComingSoon(context),
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
      _buildLogoutButton(context),
      const SizedBox(height: 32),
    ];
  }

  // ---------------------------------------------------------------------------
  // Guardian settings
  // ---------------------------------------------------------------------------

  List<Widget> _buildGuardianSettings(BuildContext context, AuthState auth) {
    return [
      // Mi familia
      _sectionLabel('Mi familia'),
      GiciCard(
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.child_care_rounded,
              iconBg: const Color(0xFFFCE4EC),
              iconColor: const Color(0xFFE91E63),
              title: 'Mis hijos',
              subtitle: 'Ver informacion de tus hijos',
              onTap: () => context.go('/children'),
            ),
          ],
        ),
      ),

      // Privacidad
      const SizedBox(height: 8),
      _sectionLabel('Privacidad'),
      GiciCard(
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.verified_user_outlined,
              iconBg: const Color(0xFFE8F5E9),
              iconColor: const Color(0xFF66BB6A),
              title: 'Consentimientos RGPD',
              onTap: () => context.go('/consent'),
            ),
          ],
        ),
      ),

      // Acerca de
      const SizedBox(height: 8),
      _sectionLabel('Acerca de'),
      GiciCard(
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.info_outline_rounded,
              iconBg: Colors.grey.shade100,
              iconColor: Colors.grey.shade600,
              title: 'GiCi App',
              subtitle: 'Version 1.0.0',
              showChevron: false,
            ),
            const Divider(height: 1),
            _SettingsTile(
              icon: Icons.privacy_tip_outlined,
              iconBg: const Color(0xFFE3F2FD),
              iconColor: const Color(0xFF42A5F5),
              title: 'Politica de privacidad',
              onTap: () => _showComingSoon(context),
            ),
            const Divider(height: 1),
            _SettingsTile(
              icon: Icons.description_outlined,
              iconBg: const Color(0xFFFFF3E0),
              iconColor: const Color(0xFFFFA726),
              title: 'Terminos y condiciones',
              onTap: () => _showComingSoon(context),
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
      _buildLogoutButton(context),
      const SizedBox(height: 32),
    ];
  }

  // ---------------------------------------------------------------------------
  // Shared widgets
  // ---------------------------------------------------------------------------

  Widget _sectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10, top: 4),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.grey.shade700,
          letterSpacing: -0.2,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GiciCard(
      onTap: () {
        showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'Cerrar sesion',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: const Text(
                '\u00bfEstas seguro de que quieres cerrar sesion?',
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
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.red, size: 20),
          SizedBox(width: 8),
          Text(
            'Cerrar sesion',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proximamente')),
    );
  }

  String _roleLabel(AppRole? role) {
    switch (role) {
      case AppRole.platformSuperAdmin:
        return 'Super Admin';
      case AppRole.organizationAdmin:
        return 'Direccion';
      case AppRole.staff:
        return 'Personal';
      case AppRole.otherStaff:
        return 'Otro personal';
      case AppRole.guardian:
        return 'Familia';
      case null:
        return 'Sin rol';
    }
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.showChevron = true,
    this.iconBg,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showChevron;
  final Color? iconBg;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg ?? Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  size: 20, color: iconColor ?? Colors.grey.shade600),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
            ),
            if (showChevron && onTap != null)
              Icon(Icons.chevron_right_rounded,
                  size: 22, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
