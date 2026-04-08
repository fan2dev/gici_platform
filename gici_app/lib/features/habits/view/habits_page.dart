import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../children/data/child_repository.dart';
import '../../classrooms/data/classroom_repository.dart';
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
        classroomRepository: sl<ClassroomRepository>(),
      )..loadClassrooms(),
      child: const _HabitsView(),
    );
  }
}

class _HabitsView extends StatelessWidget {
  const _HabitsView();

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
          body: CustomScrollView(
            slivers: [
              // Classroom selector
              SliverToBoxAdapter(
                child: _buildClassroomSelector(context, state),
              ),
              // Date navigator
              SliverToBoxAdapter(
                child: _buildDateNav(context, state),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              // Children grid
              SliverToBoxAdapter(
                child: _buildChildrenGrid(context, state),
              ),
              // Timeline content
              _buildTimelineContent(context, state, canManage),
            ],
          ),
        );
      },
    );
  }

  // -- Classroom selector -----------------------------------------------------

  Widget _buildClassroomSelector(BuildContext context, HabitsState state) {
    if (state.isLoadingClassrooms) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: LinearProgressIndicator(),
      );
    }

    if (state.classrooms.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: GiciCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<UuidValue>(
            value: state.selectedClassroomId,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            selectedItemBuilder: (context) {
              return state.classrooms.map((c) {
                return Row(
                  children: [
                    Icon(
                      Icons.class_rounded,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      c.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
            items: state.classrooms
                .map(
                  (c) => DropdownMenuItem<UuidValue>(
                    value: c.id,
                    child: Text(c.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                context.read<HabitsCubit>().selectClassroom(value);
              }
            },
          ),
        ),
      ),
    );
  }

  // -- Date navigator ---------------------------------------------------------

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

  // -- Children grid ----------------------------------------------------------

  Widget _buildChildrenGrid(BuildContext context, HabitsState state) {
    if (state.isLoadingChildren) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: LinearProgressIndicator()),
      );
    }

    if (state.classroomChildren.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Center(
            child: Text(
              'No hay alumnos en esta aula.',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }

    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: state.classroomChildren.map((child) {
          final isSelected = child.id == state.selectedChildId;
          final name = '${child.firstName} ${child.lastName}';
          return GestureDetector(
            onTap: () => context.read<HabitsCubit>().selectChild(child.id!),
            child: Container(
              width: (MediaQuery.of(context).size.width - 32 - 24) / 4,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? primary.withValues(alpha: 0.08)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? primary : Colors.grey.shade200,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GiciAvatar(
                    name: name,
                    radius: 20,
                    color: isSelected ? primary : null,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    child.firstName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? primary : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // -- Timeline content -------------------------------------------------------

  SliverPadding _buildTimelineContent(
    BuildContext context,
    HabitsState state,
    bool canManage,
  ) {
    // No child selected
    if (state.selectedChildId == null) {
      return const SliverPadding(
        padding: EdgeInsets.only(top: 40),
        sliver: SliverToBoxAdapter(
          child: EmptyState(
            message: 'Selecciona un alumno para ver sus h\u00E1bitos.',
            icon: Icons.person_search,
          ),
        ),
      );
    }

    // Error
    if (state.errorMessage != null && state.dailyHabits == null) {
      return SliverPadding(
        padding: const EdgeInsets.only(top: 20),
        sliver: SliverToBoxAdapter(
          child: ErrorState(
            message: state.errorMessage!,
            onRetry: () => context.read<HabitsCubit>().loadDailyHabits(),
          ),
        ),
      );
    }

    // Loading
    if (state.isLoadingHabits) {
      return const SliverPadding(
        padding: EdgeInsets.only(top: 20),
        sliver: SliverToBoxAdapter(
          child: LoadingState(message: 'Cargando h\u00E1bitos...'),
        ),
      );
    }

    final daily = state.dailyHabits;
    if (daily == null) {
      return const SliverPadding(
        padding: EdgeInsets.only(top: 40),
        sliver: SliverToBoxAdapter(
          child: EmptyState(
            message: 'Cargando...',
            icon: Icons.hourglass_empty,
          ),
        ),
      );
    }

    // Build combined timeline entries
    final entries = _buildTimelineEntries(daily);

    if (entries.isEmpty) {
      return const SliverPadding(
        padding: EdgeInsets.only(top: 40),
        sliver: SliverToBoxAdapter(
          child: EmptyState(
            message: 'Sin registros para este d\u00EDa.',
            icon: Icons.event_note_outlined,
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final entry = entries[index];
            final isLast = index == entries.length - 1;
            return _VisualTimelineItem(
              entry: entry,
              isLast: isLast,
              canManage: canManage,
              onEdit: canManage ? () => _onEditEntry(context, entry) : null,
            );
          },
          childCount: entries.length,
        ),
      ),
    );
  }

  // -- Timeline entry builder -------------------------------------------------

  void _onEditEntry(BuildContext context, _TimelineEntry entry) {
    if (entry.meal != null) {
      _openMealForm(context, existing: entry.meal);
    } else if (entry.nap != null) {
      _openNapForm(context, existing: entry.nap);
    } else if (entry.bowel != null) {
      _openBowelForm(context, existing: entry.bowel);
    }
  }

  List<_TimelineEntry> _buildTimelineEntries(ChildDailyHabits daily) {
    final entries = <_TimelineEntry>[];

    // Meals
    for (final meal in daily.meals) {
      entries.add(_TimelineEntry(
        sortTime: meal.recordedAt,
        accentColor: const Color(0xFFFF8A65),
        emoji: _mealEmoji(meal.mealType),
        timeLabel: _formatTime(meal.recordedAt),
        typeBadge: _mealTypeLabel(meal.mealType),
        detailBadge: _consumptionLabel(meal.consumptionLevel),
        detailColor: _consumptionColor(meal.consumptionLevel),
        notes: meal.notes,
        meal: meal,
      ));
    }

    // Naps
    for (final nap in daily.naps) {
      final duration =
          nap.durationMinutes != null ? '${nap.durationMinutes} min' : null;
      entries.add(_TimelineEntry(
        sortTime: nap.startedAt,
        accentColor: const Color(0xFF7986CB),
        emoji: '\u{1F634}',
        timeLabel: _formatTime(nap.startedAt),
        timeSubLabel:
            nap.endedAt != null ? _formatTime(nap.endedAt!) : null,
        typeBadge: 'Siesta',
        detailBadge: duration,
        detailColor: const Color(0xFF7986CB),
        notes: nap.notes,
        nap: nap,
      ));
    }

    // Bowel movements
    for (final bowel in daily.bowelMovements) {
      entries.add(_TimelineEntry(
        sortTime: bowel.eventAt,
        accentColor: const Color(0xFF4DB6AC),
        emoji: '\u{1F6BD}',
        timeLabel: _formatTime(bowel.eventAt),
        typeBadge: _bowelTypeLabel(bowel.eventType),
        detailBadge: bowel.consistency != null && bowel.consistency!.isNotEmpty
            ? _consistencyLabel(bowel.consistency!)
            : null,
        detailColor: const Color(0xFF4DB6AC),
        subtitle: null,
        notes: bowel.notes,
        bowel: bowel,
      ));
    }

    // Sort by time descending (most recent first)
    entries.sort((a, b) => b.sortTime.compareTo(a.sortTime));
    return entries;
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
                          label: 'Deposici\u00F3n',
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

  // -- Formatting helpers ---------------------------------------------------

  static String _formatShortDate(DateTime d) {
    const months = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  static String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  static String _mealTypeLabel(String type) {
    switch (type) {
      case 'bottle':
        return 'Biber\u00F3n';
      case 'breakfast':
        return 'Desayuno';
      case 'lunch':
        return 'Comida';
      case 'lunch_first':
        return 'Primer plato';
      case 'lunch_second':
        return 'Segundo plato';
      case 'snack':
        return 'Merienda';
      case 'dessert':
        return 'Postre';
      default:
        return type;
    }
  }

  static String _mealEmoji(String type) {
    switch (type) {
      case 'bottle':
        return '\u{1F37C}';
      case 'breakfast':
        return '\u{1F305}';
      case 'lunch':
        return '\u{1F37D}\u{FE0F}';
      case 'snack':
        return '\u{1F36A}';
      default:
        return '\u{1F37D}\u{FE0F}';
    }
  }

  static String _consumptionLabel(String level) {
    switch (level) {
      case 'none':
        return 'Nada';
      case 'little':
        return 'Poco';
      case 'half':
        return 'Mitad';
      case 'most':
        return 'Bastante';
      case 'all':
        return 'Todo';
      default:
        return level;
    }
  }

  static Color _consumptionColor(String level) {
    switch (level) {
      case 'little':
        return const Color(0xFFFF7043);
      case 'most':
        return const Color(0xFF66BB6A);
      case 'all':
        return const Color(0xFF43A047);
      default:
        return Colors.grey;
    }
  }

  static String _bowelTypeLabel(String type) {
    switch (type) {
      case 'toilet':
        return 'WC';
      case 'diaper':
        return 'Pa\u00F1al';
      case 'diaper_change':
        return 'Cambio pa\u00F1al';
      case 'accident':
        return 'Accidente';
      default:
        return type;
    }
  }

  static String _consistencyLabel(String consistency) {
    switch (consistency) {
      case 'liquid':
        return 'L\u00EDquido';
      case 'normal':
        return 'Normal';
      case 'hard':
        return 'Dura';
      default:
        return consistency;
    }
  }
}

// ---------------------------------------------------------------------------
// Visual timeline item (dots + vertical line, like child_timeline_page)
// ---------------------------------------------------------------------------

class _VisualTimelineItem extends StatelessWidget {
  const _VisualTimelineItem({
    required this.entry,
    required this.isLast,
    required this.canManage,
    this.onEdit,
  });

  final _TimelineEntry entry;
  final bool isLast;
  final bool canManage;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: entry.accentColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: entry.accentColor.withValues(alpha: 0.3),
                      width: 3,
                    ),
                  ),
                ),
                // Connecting line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Event card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: emoji + time + badges
                      Row(
                        children: [
                          Text(
                            entry.emoji,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            entry.timeLabel,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          if (entry.timeSubLabel != null) ...[
                            Text(
                              ' - ${entry.timeSubLabel}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                          const Spacer(),
                          if (canManage)
                            Icon(
                              Icons.edit_rounded,
                              size: 16,
                              color: Colors.grey.shade300,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Badges row
                      Row(
                        children: [
                          StatusPill(
                            label: entry.typeBadge,
                            color: entry.accentColor,
                            small: true,
                          ),
                          if (entry.detailBadge != null) ...[
                            const SizedBox(width: 6),
                            StatusPill(
                              label: entry.detailBadge!,
                              color: entry.detailColor ?? Colors.grey,
                              small: true,
                            ),
                          ],
                        ],
                      ),
                      // Subtitle
                      if (entry.subtitle != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          entry.subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                      // Notes
                      if (entry.notes != null &&
                          entry.notes!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          entry.notes!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Timeline entry model (private)
// ---------------------------------------------------------------------------

class _TimelineEntry {
  _TimelineEntry({
    required this.sortTime,
    required this.accentColor,
    required this.emoji,
    required this.timeLabel,
    this.timeSubLabel,
    required this.typeBadge,
    this.detailBadge,
    this.detailColor,
    this.subtitle,
    this.notes,
    this.meal,
    this.nap,
    this.bowel,
  });

  final DateTime sortTime;
  final Color accentColor;
  final String emoji;
  final String timeLabel;
  final String? timeSubLabel;
  final String typeBadge;
  final String? detailBadge;
  final Color? detailColor;
  final String? subtitle;
  final String? notes;
  final MealEntry? meal;
  final NapEntry? nap;
  final BowelMovementEntry? bowel;
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
