import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../children/data/child_repository.dart';
import '../cubit/habits_cubit.dart';
import '../data/habit_repository.dart';
import 'bowel_form_page.dart';
import 'meal_form_page.dart';
import 'nap_form_page.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HabitsCubit(
        habitRepository: sl<HabitRepository>(),
        childRepository: sl<ChildRepository>(),
      )..loadChildren(),
      child: const _HabitsView(),
    );
  }
}

class _HabitsView extends StatefulWidget {
  const _HabitsView();

  @override
  State<_HabitsView> createState() => _HabitsViewState();
}

class _HabitsViewState extends State<_HabitsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('No autorizado')));
    }

    final canManage = auth.isStaffOrAbove;

    return BlocBuilder<HabitsCubit, HabitsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Seguimiento',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            backgroundColor: const Color(0xFFF5F5F7),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => context.go('/dashboard'),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          floatingActionButton:
              canManage && state.selectedChildId != null
                  ? FloatingActionButton.extended(
                      onPressed: () => _showAddMenu(context),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text(
                        'Nuevo registro',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    )
                  : null,
          body: Column(
            children: [
              // Child selector
              _buildChildSelector(context, state),
              // Date nav
              _buildDateNav(context, state),
              const SizedBox(height: 8),
              // Tab bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                  ),
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey.shade500,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\u{1F37D}\u{FE0F} '),
                          Text('Comidas'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\u{1F634} '),
                          Text('Siestas'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\u{1F6BD} '),
                          Text('Dep.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Content
              Expanded(
                child: _buildContent(context, state, canManage),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChildSelector(BuildContext context, HabitsState state) {
    if (state.isLoadingChildren) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: LinearProgressIndicator(),
      );
    }

    if (state.children.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedChild = state.selectedChild;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: GiciCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<UuidValue>(
            value: state.selectedChildId,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            selectedItemBuilder: (context) {
              return state.children.map((c) {
                final name = '${c.firstName} ${c.lastName}';
                return Row(
                  children: [
                    GiciAvatar(name: name, radius: 16),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
            items: state.children
                .map(
                  (c) => DropdownMenuItem<UuidValue>(
                    value: c.id,
                    child: Text('${c.firstName} ${c.lastName}'),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                context.read<HabitsCubit>().selectChild(value);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateNav(BuildContext context, HabitsState state) {
    final date = state.selectedDate ?? DateTime.now();
    final today = DateTime.now();
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => context.read<HabitsCubit>().previousDay(),
            icon: const Icon(Icons.chevron_left_rounded),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2020),
                  lastDate: today.add(const Duration(days: 1)),
                );
                if (picked != null && context.mounted) {
                  context.read<HabitsCubit>().selectDate(picked);
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    isToday
                        ? 'Hoy - ${_formatShortDate(date)}'
                        : _formatShortDate(date),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: isToday
                ? null
                : () => context.read<HabitsCubit>().nextDay(),
            icon: const Icon(Icons.chevron_right_rounded),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HabitsState state,
    bool canManage,
  ) {
    if (state.children.isEmpty && !state.isLoadingChildren) {
      return const EmptyState(
        message: 'No hay alumnos disponibles.',
        icon: Icons.child_care,
      );
    }

    if (state.errorMessage != null && state.dailyHabits == null) {
      return ErrorState(
        message: state.errorMessage!,
        onRetry: () => context.read<HabitsCubit>().loadDailyHabits(),
      );
    }

    if (state.isLoadingHabits) {
      return const LoadingState(message: 'Cargando habitos...');
    }

    final daily = state.dailyHabits;
    if (daily == null) {
      return const EmptyState(
        message: 'Selecciona un alumno para ver sus habitos.',
        icon: Icons.person_search,
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _MealsTab(
          meals: daily.meals,
          canManage: canManage,
          onAdd: () => _openMealForm(context),
          onEdit: (m) => _openMealForm(context, existing: m),
        ),
        _NapsTab(
          naps: daily.naps,
          canManage: canManage,
          onAdd: () => _openNapForm(context),
          onEdit: (n) => _openNapForm(context, existing: n),
        ),
        _BowelTab(
          entries: daily.bowelMovements,
          canManage: canManage,
          onAdd: () => _openBowelForm(context),
          onEdit: (b) => _openBowelForm(context, existing: b),
        ),
      ],
    );
  }

  // -- Navigation helpers ---------------------------------------------------

  void _showAddMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nuevo registro',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _AddOptionCard(
                          emoji: '\u{1F37D}\u{FE0F}',
                          label: 'Comida',
                          color: const Color(0xFFFF8A65),
                          onTap: () {
                            Navigator.pop(sheetCtx);
                            _openMealForm(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AddOptionCard(
                          emoji: '\u{1F634}',
                          label: 'Siesta',
                          color: const Color(0xFF7986CB),
                          onTap: () {
                            Navigator.pop(sheetCtx);
                            _openNapForm(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AddOptionCard(
                          emoji: '\u{1F6BD}',
                          label: 'Deposicion',
                          color: const Color(0xFF4DB6AC),
                          onTap: () {
                            Navigator.pop(sheetCtx);
                            _openBowelForm(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openMealForm(BuildContext context, {MealEntry? existing}) {
    final cubit = context.read<HabitsCubit>();
    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: MealFormPage(existingMeal: existing),
        ),
      ),
    );
  }

  void _openNapForm(BuildContext context, {NapEntry? existing}) {
    final cubit = context.read<HabitsCubit>();
    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: NapFormPage(existingNap: existing),
        ),
      ),
    );
  }

  void _openBowelForm(BuildContext context, {BowelMovementEntry? existing}) {
    final cubit = context.read<HabitsCubit>();
    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: BowelFormPage(existingEntry: existing),
        ),
      ),
    );
  }

  static String _formatShortDate(DateTime d) {
    const months = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

// ---------------------------------------------------------------------------
// Add option card for bottom sheet
// ---------------------------------------------------------------------------
class _AddOptionCard extends StatelessWidget {
  const _AddOptionCard({
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Formatting helpers
// ---------------------------------------------------------------------------
String _formatTime(DateTime dt) {
  return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

String _mealTypeLabel(String type) {
  switch (type) {
    case 'breakfast':
      return 'Desayuno';
    case 'lunch':
      return 'Almuerzo';
    case 'snack':
      return 'Merienda';
    case 'dinner':
      return 'Cena';
    default:
      return type;
  }
}

String _consumptionLabel(String level) {
  switch (level) {
    case 'none':
      return 'Nada';
    case 'little':
      return 'Poco';
    case 'half':
      return 'Mitad';
    case 'most':
      return 'Casi todo';
    case 'all':
      return 'Todo';
    default:
      return level;
  }
}

Color _consumptionColor(String level) {
  switch (level) {
    case 'none':
      return const Color(0xFFE53935);
    case 'little':
      return const Color(0xFFFF7043);
    case 'half':
      return const Color(0xFFFFA726);
    case 'most':
      return const Color(0xFF66BB6A);
    case 'all':
      return const Color(0xFF43A047);
    default:
      return Colors.grey;
  }
}

// ---------------------------------------------------------------------------
// Meals tab
// ---------------------------------------------------------------------------
class _MealsTab extends StatelessWidget {
  const _MealsTab({
    required this.meals,
    required this.canManage,
    required this.onAdd,
    required this.onEdit,
  });

  final List<MealEntry> meals;
  final bool canManage;
  final VoidCallback onAdd;
  final void Function(MealEntry) onEdit;

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const EmptyState(
        icon: Icons.restaurant_outlined,
        message: 'Sin comidas registradas.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
      itemCount: meals.length,
      itemBuilder: (context, i) {
        final meal = meals[i];
        return GiciCard(
          onTap: canManage ? () => onEdit(meal) : null,
          child: Row(
            children: [
              // Time
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatTime(meal.recordedAt),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusPill(
                      label: _mealTypeLabel(meal.mealType),
                      color: const Color(0xFFFF8A65),
                      small: true,
                    ),
                    const SizedBox(height: 6),
                    StatusPill(
                      label: _consumptionLabel(meal.consumptionLevel),
                      color: _consumptionColor(meal.consumptionLevel),
                      small: true,
                    ),
                    if (meal.notes != null && meal.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        meal.notes!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (canManage)
                Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Naps tab
// ---------------------------------------------------------------------------
class _NapsTab extends StatelessWidget {
  const _NapsTab({
    required this.naps,
    required this.canManage,
    required this.onAdd,
    required this.onEdit,
  });

  final List<NapEntry> naps;
  final bool canManage;
  final VoidCallback onAdd;
  final void Function(NapEntry) onEdit;

  @override
  Widget build(BuildContext context) {
    if (naps.isEmpty) {
      return const EmptyState(
        icon: Icons.bedtime_outlined,
        message: 'Sin siestas registradas.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
      itemCount: naps.length,
      itemBuilder: (context, i) {
        final nap = naps[i];
        final duration =
            nap.durationMinutes != null ? '${nap.durationMinutes} min' : '';

        return GiciCard(
          onTap: canManage ? () => onEdit(nap) : null,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      _formatTime(nap.startedAt),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    if (nap.endedAt != null) ...[
                      Text(
                        _formatTime(nap.endedAt!),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (duration.isNotEmpty)
                      Text(
                        duration,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    if (nap.sleepQuality != null) ...[
                      const SizedBox(height: 4),
                      StatusPill(
                        label: _qualityLabel(nap.sleepQuality!),
                        color: _qualityColor(nap.sleepQuality!),
                        small: true,
                      ),
                    ],
                    if (nap.notes != null && nap.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        nap.notes!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (canManage)
                Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
        );
      },
    );
  }

  String _qualityLabel(String q) {
    switch (q) {
      case 'good':
        return 'Buena';
      case 'fair':
        return 'Regular';
      case 'poor':
        return 'Mala';
      case 'restless':
        return 'Inquieto';
      default:
        return q;
    }
  }

  Color _qualityColor(String q) {
    switch (q) {
      case 'good':
        return const Color(0xFF43A047);
      case 'fair':
        return const Color(0xFFFFA726);
      case 'poor':
        return const Color(0xFFE53935);
      case 'restless':
        return const Color(0xFFFF7043);
      default:
        return Colors.grey;
    }
  }
}

// ---------------------------------------------------------------------------
// Bowel tab
// ---------------------------------------------------------------------------
class _BowelTab extends StatelessWidget {
  const _BowelTab({
    required this.entries,
    required this.canManage,
    required this.onAdd,
    required this.onEdit,
  });

  final List<BowelMovementEntry> entries;
  final bool canManage;
  final VoidCallback onAdd;
  final void Function(BowelMovementEntry) onEdit;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const EmptyState(
        icon: Icons.baby_changing_station_outlined,
        message: 'Sin deposiciones registradas.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final entry = entries[i];
        return GiciCard(
          onTap: canManage ? () => onEdit(entry) : null,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _formatTime(entry.eventAt),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusPill(
                      label: _bowelTypeLabel(entry.eventType),
                      color: const Color(0xFF4DB6AC),
                      small: true,
                    ),
                    if (entry.consistency != null &&
                        entry.consistency!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Consistencia: ${entry.consistency}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                    if (entry.notes != null &&
                        entry.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        entry.notes!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (canManage)
                Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
        );
      },
    );
  }

  String _bowelTypeLabel(String type) {
    switch (type) {
      case 'diaper_change':
        return 'Panal';
      case 'toilet':
        return 'WC';
      default:
        return type;
    }
  }
}
