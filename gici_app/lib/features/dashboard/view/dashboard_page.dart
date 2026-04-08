import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../core/config/app_config.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../time_tracking/data/time_tracking_repository.dart';
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
                  // -- Compact header ---------------------------------------
                  SliverToBoxAdapter(child: _CompactHeader(auth: auth)),

                  // -- Body content -----------------------------------------
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
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
    BuildContext context,
    AuthState auth,
    DashboardState state,
  ) {
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
// Compact header — two-line greeting + center logo
// ---------------------------------------------------------------------------

class _CompactHeader extends StatelessWidget {
  const _CompactHeader({required this.auth});

  final AuthState auth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = _greeting(now.hour);
    final dateStr = DateFormat("EEEE, d 'de' MMMM", 'es_ES').format(now);
    final capitalizedDate = dateStr[0].toUpperCase() + dateStr.substring(1);
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final firstName = auth.firstName ?? '';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, primary.withValues(alpha: 0.85)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
          child: Row(
            children: [
              // Left side: Avatar + greeting
              GiciAvatar(
                name: firstName,
                radius: 20,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$greeting, $firstName',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      capitalizedDate,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              // Right side: Center/org logo placeholder
              Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.child_care_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppConfig.current.appName,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        // -- Inline time-tracking check-in/out for staff -------------------
        if (auth.isStaffOrAbove) ...[
          _TimeTrackingWidget(),
          const SizedBox(height: 8),
        ],

        // -- Quick actions (primary content) --------------------------------
        const Text(
          '\u26A1 Acciones rápidas',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4),
        _QuickActionsGrid(auth: auth),

        // -- Today's menu (always visible) -----------------------------------
        const SizedBox(height: 16),
        const SectionHeader(title: '\u{1F37D}\u{FE0F} Men\u00FA de hoy'),
        if (summary.todayMenuEntries.isEmpty)
          GiciCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.restaurant_menu, size: 20, color: Colors.grey.shade400),
                const SizedBox(width: 10),
                Text('No hay men\u00FA para hoy',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
              ],
            ),
          )
        else ...[
          GiciCard(
            accentColor: const Color(0xFFFB8C00),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Builder(builder: (context) {
              final normalEntries = summary.todayMenuEntries
                  .where((e) => e.menuTrack == 'normal')
                  .toList();
              final trituradoEntries = summary.todayMenuEntries
                  .where((e) => e.menuTrack == 'menu2')
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (normalEntries.isNotEmpty) ...[
                    Text(
                      '\u{1F37D}\u{FE0F} Men\u00fa Normal',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var i = 0; i < normalEntries.length; i++) ...[
                      _CompactMenuRow(entry: normalEntries[i]),
                      if (i < normalEntries.length - 1)
                        Divider(height: 16, color: Colors.grey.shade100),
                    ],
                  ],
                  if (normalEntries.isNotEmpty && trituradoEntries.isNotEmpty)
                    Divider(height: 24, color: Colors.grey.shade300),
                  if (trituradoEntries.isNotEmpty) ...[
                    Text(
                      '\u{1F963} Men\u00fa Triturado',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var i = 0; i < trituradoEntries.length; i++) ...[
                      _CompactMenuRow(entry: trituradoEntries[i]),
                      if (i < trituradoEntries.length - 1)
                        Divider(height: 16, color: Colors.grey.shade100),
                    ],
                  ],
                ],
              );
            }),
          ),
        ],

        // -- Today's events ---------------------------------------------------
        if (summary.todayEvents.isNotEmpty) ...[
          const SizedBox(height: 16),
          const SectionHeader(title: '\u{1F4C5} Eventos hoy'),
          ...summary.todayEvents.map((event) {
            return GiciCard(
              accentColor: _eventColor(event.eventType),
              onTap: () => context.go('/calendar'),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  Text(_eventEmoji(event.eventType), style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        if (event.description != null && event.description!.isNotEmpty)
                          Text(event.description!,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],

        // -- Recent notifications (compact, max 3) -------------------------
        if (summary.recentNotifications.isNotEmpty) ...[
          const SizedBox(height: 16),
          const SectionHeader(title: '\u{1F514} Notificaciones recientes'),
          ...summary.recentNotifications.take(3).map((notif) {
            return GiciCard(
              onTap: () => context.go('/notifications'),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  if (!notif.isRead)
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  else
                    const SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: notif.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (notif.body.isNotEmpty)
                          Text(
                            notif.body,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                    size: 18,
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Inline time tracking check-in / check-out widget (compact)
// ---------------------------------------------------------------------------

class _TimeTrackingWidget extends StatefulWidget {
  @override
  State<_TimeTrackingWidget> createState() => _TimeTrackingWidgetState();
}

class _TimeTrackingWidgetState extends State<_TimeTrackingWidget> {
  bool _loading = true;
  bool _checkedIn = false;
  DateTime? _checkInTime;
  bool _acting = false;
  String _workedToday = '0h 0m';

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    try {
      final repo = sl<TimeTrackingRepository>();
      final entries = await repo.myEntries(page: 0, pageSize: 50);
      if (!mounted) return;

      // Calculate worked hours today
      final now = DateTime.now();
      final todayEntries = entries.where((e) {
        final local = e.recordedAt.toLocal();
        return local.year == now.year &&
            local.month == now.month &&
            local.day == now.day;
      }).toList();

      Duration totalWorked = Duration.zero;
      DateTime? lastCheckIn;
      // Sort chronologically
      todayEntries.sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
      for (final entry in todayEntries) {
        if (entry.entryType == 'check_in') {
          lastCheckIn = entry.recordedAt;
        } else if (entry.entryType == 'check_out' && lastCheckIn != null) {
          totalWorked += entry.recordedAt.difference(lastCheckIn);
          lastCheckIn = null;
        }
      }
      // If still checked in, add time until now
      if (lastCheckIn != null) {
        totalWorked += now.toUtc().difference(lastCheckIn);
      }

      final hours = totalWorked.inHours;
      final minutes = totalWorked.inMinutes % 60;

      if (entries.isNotEmpty) {
        final last = entries.first;
        final isCheckIn = last.entryType == 'check_in';
        setState(() {
          _checkedIn = isCheckIn;
          _checkInTime = isCheckIn ? last.recordedAt : null;
          _workedToday = '${hours}h ${minutes}m';
          _loading = false;
        });
      } else {
        setState(() {
          _workedToday = '0h 0m';
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggle() async {
    if (_acting) return;

    if (_checkedIn) {
      // Show checkout reason selector
      _showCheckOutReasons();
      return;
    }

    setState(() => _acting = true);
    try {
      final repo = sl<TimeTrackingRepository>();
      final entry = await repo.checkIn();
      if (mounted) {
        setState(() {
          _checkedIn = true;
          _checkInTime = entry.recordedAt;
          _acting = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _acting = false);
    }
  }

  void _showCheckOutReasons() {
    final reasons = [
      ('☕', 'Pausa'),
      ('🍽️', 'Comida'),
      ('🏁', 'Fin de jornada'),
      ('🏥', 'Médico'),
      ('👶', 'Asunto personal'),
    ];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetCtx) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Motivo de salida',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              ...reasons.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () async {
                        Navigator.pop(sheetCtx);
                        setState(() => _acting = true);
                        try {
                          final repo = sl<TimeTrackingRepository>();
                          await repo.checkOut(notes: r.$2);
                          if (mounted) {
                            setState(() {
                              _checkedIn = false;
                              _checkInTime = null;
                              _acting = false;
                            });
                          }
                        } catch (_) {
                          if (mounted) setState(() => _acting = false);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          children: [
                            Text(r.$1, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 12),
                            Text(r.$2, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    if (_loading) {
      return GiciCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: primary),
            ),
            const SizedBox(width: 10),
            Text(
              'Cargando registro...',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    final Color cardColor = _checkedIn
        ? const Color(0xFFD32F2F) // Red for check-out
        : const Color(0xFF2E7D32); // Green for check-in

    final String statusLabel = _checkedIn
        ? 'Trabajando ${DateFormat.Hm().format(_checkInTime!)}'
        : 'Sin fichar';

    final IconData icon = _checkedIn
        ? Icons.logout_rounded
        : Icons.login_rounded;

    final String buttonLabel = _checkedIn
        ? 'Registrar salida'
        : 'Registrar entrada';

    return GiciCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Compact check-in/out row
          Material(
            color: cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: InkWell(
              onTap: _acting ? null : _toggle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    if (_acting)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      Icon(icon, color: Colors.white, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        buttonLabel,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Info row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                Text(
                  statusLabel,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 8),
                Text('\u00B7', style: TextStyle(color: Colors.grey.shade400)),
                const SizedBox(width: 8),
                Text(
                  '$_workedToday hoy',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => context.go('/time-tracking'),
                  child: Text(
                    'Ver control horario \u2192',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Event helpers
// ---------------------------------------------------------------------------

String _eventEmoji(String type) {
  switch (type) {
    case 'holiday': return '🏖️';
    case 'meeting': return '👥';
    case 'excursion': return '🚌';
    case 'celebration': return '🎉';
    case 'closure': return '🔒';
    default: return '📅';
  }
}

Color _eventColor(String type) {
  switch (type) {
    case 'holiday': return const Color(0xFF42A5F5);
    case 'meeting': return const Color(0xFF7E57C2);
    case 'excursion': return const Color(0xFF66BB6A);
    case 'celebration': return const Color(0xFFFFA726);
    case 'closure': return const Color(0xFFEF5350);
    default: return const Color(0xFF78909C);
  }
}

// ---------------------------------------------------------------------------
// Compact menu row
// ---------------------------------------------------------------------------

class _CompactMenuRow extends StatelessWidget {
  const _CompactMenuRow({required this.entry});

  final dynamic entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _mealIcon(entry.mealType),
          color: const Color(0xFFFB8C00),
          size: 16,
        ),
        const SizedBox(width: 10),
        Text(
          _mealTypeLabel(entry.mealType),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            entry.title as String,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static IconData _mealIcon(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Icons.free_breakfast_rounded;
      case 'lunch':
      case 'lunch_first':
      case 'lunch_second':
        return Icons.lunch_dining_rounded;
      case 'snack':
        return Icons.bakery_dining_rounded;
      case 'dessert':
        return Icons.cake_rounded;
      case 'bottle':
        return Icons.baby_changing_station_rounded;
      default:
        return Icons.restaurant_rounded;
    }
  }

  static String _mealTypeLabel(String mealType) {
    switch (mealType) {
      case 'bottle':
        return 'Biberon';
      case 'breakfast':
        return 'Desayuno';
      case 'lunch':
        return 'Comida';
      case 'lunch_first':
        return '1er plato';
      case 'lunch_second':
        return '2o plato';
      case 'snack':
        return 'Merienda';
      case 'dessert':
        return 'Postre';
      default:
        return mealType;
    }
  }
}

// ---------------------------------------------------------------------------
// Quick actions grid (without "Horario")
// ---------------------------------------------------------------------------

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({required this.auth});

  final AuthState auth;

  @override
  Widget build(BuildContext context) {
    final actions = <_QuickActionData>[
      // Everyone (not in bottom bar)
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
      _QuickActionData(
        icon: Icons.photo_library_rounded,
        label: 'Galerías',
        color: const Color(0xFFD81B60),
        path: '/galleries',
      ),
      _QuickActionData(
        icon: Icons.calendar_month_rounded,
        label: 'Calendario',
        color: const Color(0xFF5C6BC0),
        path: '/calendar',
      ),
      // Staff+
      if (auth.isStaffOrAbove) ...[
        _QuickActionData(
          icon: Icons.person_off_rounded,
          label: 'Ausencias',
          color: const Color(0xFFEF5350),
          path: '/absences',
        ),
      ],
      // Admin
      if (auth.isAdmin) ...[
        _QuickActionData(
          icon: Icons.admin_panel_settings_rounded,
          label: 'Dirección',
          color: const Color(0xFF8E24AA),
          path: '/direccion',
        ),
      ],
      // Always — Mi perfil
      _QuickActionData(
        icon: Icons.person_rounded,
        label: 'Mi perfil',
        color: const Color(0xFF78909C),
        path: '/settings',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 8,
        children: actions.map((action) {
          return SizedBox(
            width: 80,
            child: _QuickActionTile(
              icon: action.icon,
              label: action.label,
              color: action.color,
              onTap: () => context.go(action.path),
            ),
          );
        }).toList(),
      ),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 6),
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
