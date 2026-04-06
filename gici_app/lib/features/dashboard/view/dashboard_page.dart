import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/gradient_header.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/stat_card.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/dashboard_cubit.dart';
import '../data/dashboard_repository.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(sl<DashboardRepository>())..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, auth) {
        return BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, dashState) {
            return Scaffold(
              backgroundColor: const Color(0xFFF5F5F7),
              body: CustomScrollView(
                slivers: [
                  // -- Header ------------------------------------------------
                  SliverToBoxAdapter(
                    child: _DashboardHeader(auth: auth),
                  ),

                  // -- Body content ------------------------------------------
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 900),
                          child: _buildBody(context, auth, dashState),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context, AuthState auth, DashboardState state) {
    switch (state.status) {
      case DashboardStatus.initial:
      case DashboardStatus.loading:
        return const Padding(
          padding: EdgeInsets.only(top: 80),
          child: LoadingState(message: 'Cargando tu panel...'),
        );
      case DashboardStatus.error:
        return Padding(
          padding: const EdgeInsets.only(top: 60),
          child: ErrorState(
            message: state.errorMessage ?? 'Error al cargar el panel.',
            onRetry: () => context.read<DashboardCubit>().load(),
          ),
        );
      case DashboardStatus.loaded:
        return _DashboardContent(auth: auth, state: state);
    }
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.auth});

  final AuthState auth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = _greeting(now.hour);
    final dateStr = DateFormat("EEEE, d 'de' MMMM", 'es_ES').format(now);
    final capitalizedDate =
        dateStr[0].toUpperCase() + dateStr.substring(1);

    return GradientHeader(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting, ${auth.firstName ?? ''}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    capitalizedDate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            GiciAvatar(
              name: auth.displayName,
              radius: 22,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  String _greeting(int hour) {
    if (hour < 12) return 'Buenos dias';
    if (hour < 20) return 'Buenas tardes';
    return 'Buenas noches';
  }
}

// ---------------------------------------------------------------------------
// Dashboard content (loaded state)
// ---------------------------------------------------------------------------

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.auth, required this.state});

  final AuthState auth;
  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final summary = state.summary!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Stats row ---------------------------------------------------
        _StatsGrid(
          childrenCount: summary.childrenCount,
          classroomsCount: summary.classroomsCount,
          unreadNotifications: summary.unreadNotifications,
          pendingRequests: summary.pendingRequests,
        ),

        const SizedBox(height: 28),

        // -- Quick actions -----------------------------------------------
        SectionHeader(
          title: 'Acciones rapidas',
          action: TextButton(
            onPressed: () {},
            child: const Text('Ver todo'),
          ),
        ),
        _QuickActionsGrid(auth: auth),

        // -- Today's menu ------------------------------------------------
        if (summary.todayMenuEntries.isNotEmpty) ...[
          const SizedBox(height: 28),
          const SectionHeader(title: 'Menu de hoy'),
          GiciCard(
            accentColor: const Color(0xFFFB8C00),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final entry in summary.todayMenuEntries) ...[
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB8C00).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _mealIcon(entry.mealType),
                          color: const Color(0xFFFB8C00),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.mealType,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              entry.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (entry.description != null)
                              Text(
                                entry.description!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (entry != summary.todayMenuEntries.last)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],

        // -- Recent notifications ----------------------------------------
        if (summary.recentNotifications.isNotEmpty) ...[
          const SizedBox(height: 28),
          SectionHeader(
            title: 'Notificaciones recientes',
            action: TextButton(
              onPressed: () => context.go('/notifications'),
              child: const Text('Ver todas'),
            ),
          ),
          ...summary.recentNotifications.take(3).map((notif) {
            return GiciCard(
              onTap: () => context.go('/notifications'),
              child: Row(
                children: [
                  // Unread dot
                  if (!notif.isRead)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  else
                    const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                notif.isRead ? FontWeight.w500 : FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          notif.body,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  IconData _mealIcon(String mealType) {
    final lower = mealType.toLowerCase();
    if (lower.contains('desayuno')) return Icons.free_breakfast_rounded;
    if (lower.contains('almuerzo') || lower.contains('comida')) {
      return Icons.lunch_dining_rounded;
    }
    if (lower.contains('merienda')) return Icons.bakery_dining_rounded;
    return Icons.restaurant_rounded;
  }
}

// ---------------------------------------------------------------------------
// Stats 2x2 grid
// ---------------------------------------------------------------------------

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({
    required this.childrenCount,
    required this.classroomsCount,
    required this.unreadNotifications,
    required this.pendingRequests,
  });

  final int childrenCount;
  final int classroomsCount;
  final int unreadNotifications;
  final int pendingRequests;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 4 ? 1.3 : 1.55,
          children: [
            StatCard(
              label: 'Ninos',
              count: '$childrenCount',
              icon: Icons.child_care_rounded,
              color: const Color(0xFF1E88E5),
              onTap: () => context.go('/children'),
            ),
            StatCard(
              label: 'Aulas',
              count: '$classroomsCount',
              icon: Icons.meeting_room_rounded,
              color: const Color(0xFF43A047),
              onTap: () => context.go('/classrooms'),
            ),
            StatCard(
              label: 'Notificaciones',
              count: '$unreadNotifications',
              icon: Icons.notifications_active_rounded,
              color: const Color(0xFFFB8C00),
              onTap: () => context.go('/notifications'),
            ),
            StatCard(
              label: 'Solicitudes',
              count: '$pendingRequests',
              icon: Icons.edit_note_rounded,
              color: const Color(0xFF8E24AA),
              onTap: () => context.go('/requests'),
            ),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Quick actions grid
// ---------------------------------------------------------------------------

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({required this.auth});

  final AuthState auth;

  @override
  Widget build(BuildContext context) {
    final actions = <_QuickActionData>[
      // Everyone
      _QuickActionData(
        icon: Icons.child_care_rounded,
        label: 'Alumnos',
        color: const Color(0xFF1E88E5),
        path: '/children',
      ),
      _QuickActionData(
        icon: Icons.chat_rounded,
        label: 'Chat',
        color: const Color(0xFF00ACC1),
        path: '/chat',
      ),
      _QuickActionData(
        icon: Icons.notifications_rounded,
        label: 'Notificaciones',
        color: const Color(0xFFFB8C00),
        path: '/notifications',
      ),
      _QuickActionData(
        icon: Icons.description_rounded,
        label: 'Documentos',
        color: const Color(0xFF6D4C41),
        path: '/documents',
      ),
      // Staff+
      if (auth.isStaffOrAbove) ...[
        _QuickActionData(
          icon: Icons.restaurant_rounded,
          label: 'Habitos',
          color: const Color(0xFF43A047),
          path: '/habits',
        ),
        _QuickActionData(
          icon: Icons.meeting_room_rounded,
          label: 'Aulas',
          color: const Color(0xFF3949AB),
          path: '/classrooms',
        ),
        _QuickActionData(
          icon: Icons.access_time_rounded,
          label: 'Horario',
          color: const Color(0xFF546E7A),
          path: '/time-tracking',
        ),
        _QuickActionData(
          icon: Icons.photo_library_rounded,
          label: 'Galerias',
          color: const Color(0xFFD81B60),
          path: '/galleries',
        ),
      ],
      // Admin
      if (auth.isAdmin) ...[
        _QuickActionData(
          icon: Icons.people_rounded,
          label: 'Personal',
          color: const Color(0xFF7CB342),
          path: '/staff',
        ),
        _QuickActionData(
          icon: Icons.settings_rounded,
          label: 'Ajustes',
          color: Colors.grey,
          path: '/settings',
        ),
      ],
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 5 : 4;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return _QuickActionTile(
              icon: action.icon,
              label: action.label,
              color: action.color,
              onTap: () => context.go(action.path),
            );
          },
        );
      },
    );
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.color,
    required this.path,
  });

  final IconData icon;
  final String label;
  final Color color;
  final String path;
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
