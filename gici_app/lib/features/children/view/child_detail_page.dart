import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/gradient_header.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../habits/data/habit_repository.dart';
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
class _LoadedContent extends StatelessWidget {
  const _LoadedContent({required this.overview, required this.auth});

  final ChildProfileOverview overview;
  final AuthState auth;

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
      return '$years ano${years == 1 ? '' : 's'} $months m';
    }
    return '$months mes${months == 1 ? '' : 'es'}';
  }

  @override
  Widget build(BuildContext context) {
    final child = overview.child;
    final name = '${child.firstName} ${child.lastName}';
    final isAdmin = auth.isAdmin;

    return RefreshIndicator(
      onRefresh: () => context.read<ChildDetailCubit>().refresh(),
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
                          onPressed: () => Navigator.of(context).maybePop(),
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

          // -- Action chips --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _ActionChip(
                      label: 'Timeline',
                      icon: Icons.timeline_rounded,
                      onTap: () => context
                          .go('/timeline/${overview.child.id}'),
                    ),
                    const SizedBox(width: 8),
                    _ActionChip(
                      label: 'Informes',
                      icon: Icons.assessment_rounded,
                      onTap: () => context
                          .go('/reports/${overview.child.id}'),
                    ),
                    const SizedBox(width: 8),
                    _ActionChip(
                      label: 'Documentos',
                      icon: Icons.description_rounded,
                      onTap: () => context.go('/documents'),
                    ),
                    const SizedBox(width: 8),
                    _ActionChip(
                      label: 'Galerias',
                      icon: Icons.photo_library_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -- Quick habits row --
          if (auth.isStaffOrAbove)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Registro rapido',
                      icon: '\u{26A1}',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickHabitCircle(
                            emoji: '\u{1F37D}\u{FE0F}',
                            label: 'Comida',
                            color: const Color(0xFFFF8A65),
                            onTap: () =>
                                _registerMeal(context, child.id!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _QuickHabitCircle(
                            emoji: '\u{1F634}',
                            label: 'Siesta',
                            color: const Color(0xFF7986CB),
                            onTap: () =>
                                _registerNap(context, child.id!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _QuickHabitCircle(
                            emoji: '\u{1F6BD}',
                            label: 'Deposicion',
                            color: const Color(0xFF4DB6AC),
                            onTap: () =>
                                _registerBowel(context, child.id!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // -- Personal data card --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Datos personales',
                    icon: '\u{1F464}',
                  ),
                  GiciCard(
                    accentColor: const Color(0xFF5C6BC0),
                    child: Column(
                      children: [
                        _DetailRow(
                          label: 'Fecha de nacimiento',
                          value: DateFormat('dd/MM/yyyy')
                              .format(child.dateOfBirth),
                        ),
                        _DetailRow(
                          label: 'Aula',
                          value: overview.activeClassroomName ??
                              'Sin asignar',
                        ),
                        _DetailRow(
                          label: 'Estado',
                          value: _statusText(child.status),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -- Medical card --
          if (child.medicalNotes != null ||
              child.dietaryNotes != null ||
              child.allergies != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Salud',
                      icon: '\u{1FA7A}',
                    ),
                    GiciCard(
                      accentColor: const Color(0xFFEF5350),
                      child: Column(
                        children: [
                          if (child.medicalNotes != null)
                            _DetailRow(
                              label: 'Notas medicas',
                              value: child.medicalNotes!,
                            ),
                          if (child.dietaryNotes != null)
                            _DetailRow(
                              label: 'Dieta',
                              value: child.dietaryNotes!,
                            ),
                          if (child.allergies != null)
                            _DetailRow(
                              label: 'Alergias',
                              value: child.allergies!,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // -- Guardians card --
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Tutores',
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
                                          radius: 18,
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

  Future<void> _registerMeal(BuildContext context, UuidValue childId) async {
    try {
      await sl<HabitRepository>().createMealEntry(
        childId: childId,
        mealType: 'lunch',
        consumptionLevel: 'normal',
        recordedAt: DateTime.now(),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comida registrada')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _registerNap(BuildContext context, UuidValue childId) async {
    try {
      await sl<HabitRepository>().createNapEntry(
        childId: childId,
        startedAt: DateTime.now(),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Siesta registrada')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _registerBowel(
      BuildContext context, UuidValue childId) async {
    try {
      await sl<HabitRepository>().createBowelMovementEntry(
        childId: childId,
        eventType: 'normal',
        eventAt: DateTime.now(),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deposicion registrada')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

// ---------------------------------------------------------------------------
// Action chip
// ---------------------------------------------------------------------------
class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick habit circle button
// ---------------------------------------------------------------------------
class _QuickHabitCircle extends StatelessWidget {
  const _QuickHabitCircle({
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
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 30)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
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
