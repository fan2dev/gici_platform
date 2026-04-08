import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/gradient_header.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../classrooms/data/classroom_repository.dart';
import '../../habits/cubit/habits_cubit.dart';
import '../../habits/data/habit_repository.dart';
import '../../habits/view/bowel_form_page.dart';
import '../../habits/view/meal_form_page.dart';
import '../../habits/view/nap_form_page.dart';
import '../cubit/child_detail_cubit.dart';
import '../data/child_repository.dart';
import 'child_form_page.dart';

class ChildDetailPage extends StatelessWidget {
  const ChildDetailPage({super.key, required this.childId});

  final UuidValue childId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ChildDetailCubit(sl<ChildRepository>())..loadProfile(childId),
      child: _ChildDetailView(childId: childId),
    );
  }
}

class _ChildDetailView extends StatelessWidget {
  const _ChildDetailView({required this.childId});

  final UuidValue childId;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Sin autorizar')));
    }

    return BlocBuilder<ChildDetailCubit, ChildDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          body: _buildBody(context, state, auth),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ChildDetailState state,
    AuthState auth,
  ) {
    switch (state.status) {
      case ChildDetailStatus.initial:
      case ChildDetailStatus.loading:
        return const LoadingState(message: 'Cargando perfil...');

      case ChildDetailStatus.error:
        return ErrorState(
          message: state.errorMessage ?? 'Error desconocido',
          onRetry: () =>
              context.read<ChildDetailCubit>().loadProfile(childId),
        );

      case ChildDetailStatus.loaded:
        final overview = state.overview!;
        return _LoadedContent(overview: overview, auth: auth);
    }
  }
}

// ---------------------------------------------------------------------------
// Loaded content
// ---------------------------------------------------------------------------
class _LoadedContent extends StatefulWidget {
  const _LoadedContent({required this.overview, required this.auth});

  final ChildProfileOverview overview;
  final AuthState auth;

  @override
  State<_LoadedContent> createState() => _LoadedContentState();
}

class _LoadedContentState extends State<_LoadedContent> {
  ChildDailyHabits? _todayHabits;
  bool _habitsLoading = true;

  ChildProfileOverview get overview => widget.overview;
  AuthState get auth => widget.auth;

  @override
  void initState() {
    super.initState();
    _loadTodayHabits();
  }

  Future<void> _loadTodayHabits() async {
    try {
      final now = DateTime.now();
      final today = DateTime.utc(now.year, now.month, now.day);
      final habits = await sl<HabitRepository>().getChildDailyHabits(
        childId: overview.child.id!,
        day: today,
      );
      if (mounted) setState(() { _todayHabits = habits; _habitsLoading = false; });
    } catch (_) {
      if (mounted) setState(() => _habitsLoading = false);
    }
  }

  String _ageFromDob(DateTime dob) {
    final now = DateTime.now();
    int years = now.year - dob.year;
    int months = now.month - dob.month;
    if (now.day < dob.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    if (years > 0) {
      return '$years a\u00f1o${years == 1 ? '' : 's'} $months m';
    }
    return '$months mes${months == 1 ? '' : 'es'}';
  }

  static String _translateMenuType(String? menuType) {
    switch (menuType) {
      case 'bottle':
        return '\u{1F37C} Biber\u00f3n';
      case 'puree':
        return '\u{1F963} Pur\u00e9/Triturado';
      case 'normal':
        return '\u{1F37D}\u{FE0F} Men\u00fa normal';
      default:
        return 'Sin asignar';
    }
  }

  HabitsCubit _createHabitsCubit(UuidValue childId) {
    final cubit = HabitsCubit(
      habitRepository: sl<HabitRepository>(),
      childRepository: sl<ChildRepository>(),
      classroomRepository: sl<ClassroomRepository>(),
    );
    cubit.selectChild(childId);
    return cubit;
  }

  void _openMealForm(BuildContext context, UuidValue childId) {
    final habitsCubit = _createHabitsCubit(childId);
    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: habitsCubit,
          child: const MealFormPage(),
        ),
      ),
    );
  }

  void _openNapForm(BuildContext context, UuidValue childId) {
    final habitsCubit = _createHabitsCubit(childId);
    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: habitsCubit,
          child: const NapFormPage(),
        ),
      ),
    );
  }

  void _openBowelForm(BuildContext context, UuidValue childId) {
    final habitsCubit = _createHabitsCubit(childId);
    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: habitsCubit,
          child: const BowelFormPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = overview.child;
    final name = '${child.firstName} ${child.lastName}';
    final isAdmin = auth.isAdmin;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ChildDetailCubit>().refresh();
        _loadTodayHabits();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // -- Gradient Header --
          SliverToBoxAdapter(
            child: GradientHeader(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 28),
                child: Column(
                  children: [
                    // Top bar
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/children'),
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white),
                        ),
                        const Spacer(),
                        if (isAdmin)
                          IconButton(
                            onPressed: () async {
                              final result =
                                  await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ChildFormPage(child: child),
                                ),
                              );
                              if (result == true && context.mounted) {
                                context.read<ChildDetailCubit>().refresh();
                              }
                            },
                            icon: const Icon(Icons.edit_rounded,
                                color: Colors.white),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GiciAvatar(
                      name: name,
                      radius: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _ageFromDob(child.dateOfBirth),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatusPill(child.status),
                        if (overview.activeClassroomName != null) ...[
                          const SizedBox(width: 8),
                          StatusPill(
                            label: overview.activeClassroomName!,
                            color: Colors.white,
                            icon: Icons.meeting_room_rounded,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -- 1. Quick actions bar (Comida, Siesta, Deposicion) --
          if (auth.isStaffOrAbove)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Registro r\u00e1pido',
                      icon: '\u{26A1}',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickActionLargeButton(
                            emoji: '\u{1F37D}\u{FE0F}',
                            label: 'Comida',
                            color: const Color(0xFFFF8A65),
                            onTap: () =>
                                _openMealForm(context, child.id!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _QuickActionLargeButton(
                            emoji: '\u{1F634}',
                            label: 'Siesta',
                            color: const Color(0xFF7986CB),
                            onTap: () =>
                                _openNapForm(context, child.id!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _QuickActionLargeButton(
                            emoji: '\u{1F6BD}',
                            label: 'Deposici\u00f3n',
                            color: const Color(0xFF4DB6AC),
                            onTap: () =>
                                _openBowelForm(context, child.id!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // -- 2. Resumen de hoy --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Resumen de hoy',
                    icon: '\u{1F4CA}',
                  ),
                  if (_habitsLoading)
                    const GiciCard(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                    )
                  else if (_todayHabits == null)
                    const GiciCard(
                      child: Text(
                        'No se pudieron cargar los datos de hoy.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    GiciCard(
                      accentColor: const Color(0xFF5C6BC0),
                      child: Column(
                        children: [
                          if (_todayHabits!.meals.isEmpty &&
                              _todayHabits!.naps.isEmpty &&
                              _todayHabits!.bowelMovements.isEmpty)
                            const Text(
                              'Sin registros hoy',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            )
                          else ...[
                            _HabitSummaryRow(
                              emoji: '\u{1F37D}\u{FE0F}',
                              label: 'Comidas',
                              count: _todayHabits!.meals.length,
                            ),
                            _HabitSummaryRow(
                              emoji: '\u{1F634}',
                              label: 'Siestas',
                              count: _todayHabits!.naps.length,
                            ),
                            _HabitSummaryRow(
                              emoji: '\u{1F6BD}',
                              label: 'Deposiciones',
                              count: _todayHabits!.bowelMovements.length,
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // -- 3. Timeline link --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: GiciCard(
                onTap: () => context.go('/timeline/${overview.child.id}'),
                child: Row(
                  children: [
                    const Text('\u{1F4CB}', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Ver l\u00ednea temporal completa',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 22,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -- 4. Compact action chips: Galerias, Informes, Documentos --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: _CompactActionChip(
                      icon: Icons.photo_library_rounded,
                      label: 'Galer\u00edas',
                      color: const Color(0xFFFFA726),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CompactActionChip(
                      icon: Icons.assessment_rounded,
                      label: 'Informes',
                      color: const Color(0xFF5C6BC0),
                      onTap: () => context
                          .go('/reports/${overview.child.id}'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CompactActionChip(
                      icon: Icons.description_rounded,
                      label: 'Documentos',
                      color: const Color(0xFF26A69A),
                      onTap: () => context.go('/documents'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -- 5. Medical card --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Informaci\u00f3n m\u00e9dica',
                    icon: '\u{1FA7A}',
                  ),
                  GiciCard(
                    accentColor: const Color(0xFFEF5350),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Allergies with warning highlight
                        if (child.allergies != null &&
                            child.allergies!.isNotEmpty)
                          _WarningRow(
                            label: 'Alergias',
                            value: child.allergies!,
                          )
                        else
                          _DetailRow(
                            label: 'Alergias',
                            value: 'Ninguna registrada',
                          ),
                        if (child.medicalNotes != null &&
                            child.medicalNotes!.isNotEmpty)
                          _DetailRow(
                            label: 'Notas m\u00e9dicas',
                            value: child.medicalNotes!,
                          )
                        else
                          _DetailRow(
                            label: 'Notas m\u00e9dicas',
                            value: 'Sin notas',
                          ),
                        if (child.dietaryNotes != null &&
                            child.dietaryNotes!.isNotEmpty)
                          _DetailRow(
                            label: 'Dieta',
                            value: child.dietaryNotes!,
                          )
                        else
                          _DetailRow(
                            label: 'Dieta',
                            value: 'Sin restricciones',
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -- 6. Personal data card --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Informaci\u00f3n personal',
                    icon: '\u{1F464}',
                  ),
                  GiciCard(
                    accentColor: const Color(0xFF5C6BC0),
                    child: Column(
                      children: [
                        _DetailRow(
                          label: 'Fecha de nacimiento',
                          value: DateFormat('d \'de\' MMMM, yyyy', 'es')
                              .format(child.dateOfBirth),
                        ),
                        _DetailRow(
                          label: 'Edad',
                          value: _ageFromDob(child.dateOfBirth),
                        ),
                        _DetailRow(
                          label: 'Estado',
                          value: _statusText(child.status),
                        ),
                        _DetailRow(
                          label: '\u{1F3EB} Aula',
                          value: overview.activeClassroomName ??
                              'Sin asignar',
                        ),
                        _DetailRow(
                          label: '\u{1F37D}\u{FE0F} Tipo de men\u00fa',
                          value: _translateMenuType(child.menuType),
                        ),
                        _DetailRow(
                          label: '\u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467} Tutores',
                          value: overview.guardianDisplayNames.isNotEmpty
                              ? overview.guardianDisplayNames.join(', ')
                              : 'Sin tutores asignados',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -- 7. Guardians card --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Tutores legales',
                    icon: '\u{1F46A}',
                  ),
                  GiciCard(
                    accentColor: const Color(0xFF26A69A),
                    child: overview.guardianDisplayNames.isEmpty
                        ? const Text(
                            'Sin tutores asignados',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Column(
                            children: overview.guardianDisplayNames
                                .map(
                                  (name) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        GiciAvatar(
                                          name: name,
                                          radius: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    switch (status) {
      case 'active':
        return StatusPill.active();
      case 'inactive':
        return StatusPill.inactive();
      default:
        return StatusPill(label: _statusText(status), color: Colors.grey);
    }
  }

  String _statusText(String status) {
    switch (status) {
      case 'active':
        return 'Activo';
      case 'inactive':
        return 'Inactivo';
      case 'graduated':
        return 'Graduado';
      default:
        return status;
    }
  }
}

// ---------------------------------------------------------------------------
// Quick action large button (for detail page)
// ---------------------------------------------------------------------------
class _QuickActionLargeButton extends StatelessWidget {
  const _QuickActionLargeButton({
    required this.emoji,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Compact action chip (Informes, Galerias, Documentos)
// ---------------------------------------------------------------------------
class _CompactActionChip extends StatelessWidget {
  const _CompactActionChip({
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Habit summary row (for "Resumen de hoy")
// ---------------------------------------------------------------------------
class _HabitSummaryRow extends StatelessWidget {
  const _HabitSummaryRow({
    required this.emoji,
    required this.label,
    required this.count,
  });

  final String emoji;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: ${count > 0 ? '$count registro${count == 1 ? '' : 's'}' : '0 registros'}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail row
// ---------------------------------------------------------------------------
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Warning row (for allergies)
// ---------------------------------------------------------------------------
class _WarningRow extends StatelessWidget {
  const _WarningRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFFCC02).withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 18,
              color: Color(0xFFF57C00),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFF57C00),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
