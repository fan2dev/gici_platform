import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../children/data/child_repository.dart';
import '../../classrooms/data/classroom_repository.dart';
import '../../habits/cubit/habits_cubit.dart';
import '../../habits/data/habit_repository.dart';
import '../../habits/view/bowel_form_page.dart';
import '../../habits/view/meal_form_page.dart';
import '../../habits/view/nap_form_page.dart';
import '../cubit/children_list_cubit.dart';
import 'child_form_page.dart';

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChildrenListCubit(
        sl<ChildRepository>(),
        sl<ClassroomRepository>(),
      )..loadData(),
      child: const _ChildrenView(),
    );
  }
}

class _ChildrenView extends StatefulWidget {
  const _ChildrenView();

  @override
  State<_ChildrenView> createState() => _ChildrenViewState();
}

class _ChildrenViewState extends State<_ChildrenView> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showFilters = false;
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Child> _filtered(List<Child> children) {
    if (_searchQuery.isEmpty) return children;
    final q = _searchQuery.toLowerCase();
    return children.where((c) {
      final full = '${c.firstName} ${c.lastName}'.toLowerCase();
      return full.contains(q);
    }).toList();
  }

  void _openBulkMeal(BuildContext context, List<Child> children, String groupName) {
    _confirmAndOpenForm(context, children, groupName, 'Comida', () {
      final habitsCubit = HabitsCubit(
        habitRepository: sl<HabitRepository>(),
        childRepository: sl<ChildRepository>(),
        classroomRepository: sl<ClassroomRepository>(),
      );
      // Select first child — the form will apply to all after save
      habitsCubit.selectChild(children.first.id!);
      Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: habitsCubit,
            child: _BulkMealWrapper(children: children, habitRepo: sl<HabitRepository>()),
          ),
        ),
      );
    });
  }

  void _openBulkNap(BuildContext context, List<Child> children, String groupName) {
    _confirmAndOpenForm(context, children, groupName, 'Siesta', () {
      final habitsCubit = HabitsCubit(
        habitRepository: sl<HabitRepository>(),
        childRepository: sl<ChildRepository>(),
        classroomRepository: sl<ClassroomRepository>(),
      );
      habitsCubit.selectChild(children.first.id!);
      Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: habitsCubit,
            child: _BulkNapWrapper(children: children, habitRepo: sl<HabitRepository>()),
          ),
        ),
      );
    });
  }

  void _openBulkBowel(BuildContext context, List<Child> children, String groupName) {
    _confirmAndOpenForm(context, children, groupName, 'Deposición', () {
      final habitsCubit = HabitsCubit(
        habitRepository: sl<HabitRepository>(),
        childRepository: sl<ChildRepository>(),
        classroomRepository: sl<ClassroomRepository>(),
      );
      habitsCubit.selectChild(children.first.id!);
      Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: habitsCubit,
            child: _BulkBowelWrapper(children: children, habitRepo: sl<HabitRepository>()),
          ),
        ),
      );
    });
  }

  void _confirmAndOpenForm(BuildContext context, List<Child> children, String groupName, String type, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Registro masivo: $type', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.group, size: 16, color: Colors.amber.shade800),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Se aplicará a ${children.length} alumnos de $groupName',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.amber.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Rellena los detalles en el siguiente formulario.', style: TextStyle(fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              onConfirm();
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Future<void> _openCreateForm(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const ChildFormPage()),
    );
    if (result == true && context.mounted) {
      context.read<ChildrenListCubit>().refresh();
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
      return '${years}a ${months}m';
    }
    return '$months mes${months == 1 ? '' : 'es'}';
  }

  void _openMealForm(BuildContext context, Child child) {
    final habitsCubit = HabitsCubit(
      habitRepository: sl<HabitRepository>(),
      childRepository: sl<ChildRepository>(),
      classroomRepository: sl<ClassroomRepository>(),
    );
    habitsCubit.selectChild(child.id!);

    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: habitsCubit,
          child: const MealFormPage(),
        ),
      ),
    );
  }

  void _openNapForm(BuildContext context, Child child) {
    final habitsCubit = HabitsCubit(
      habitRepository: sl<HabitRepository>(),
      childRepository: sl<ChildRepository>(),
      classroomRepository: sl<ClassroomRepository>(),
    );
    habitsCubit.selectChild(child.id!);

    Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: habitsCubit,
          child: const NapFormPage(),
        ),
      ),
    );
  }

  void _openBowelForm(BuildContext context, Child child) {
    final habitsCubit = HabitsCubit(
      habitRepository: sl<HabitRepository>(),
      childRepository: sl<ChildRepository>(),
      classroomRepository: sl<ClassroomRepository>(),
    );
    habitsCubit.selectChild(child.id!);

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
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Sin autorizar')));
    }

    final isAdmin = auth.isAdmin;

    return BlocBuilder<ChildrenListCubit, ChildrenListState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          body: SafeArea(
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ChildrenListState state) {
    switch (state.status) {
      case ChildrenListStatus.initial:
      case ChildrenListStatus.loading:
        return const LoadingState(message: 'Cargando alumnos...');

      case ChildrenListStatus.error:
        return ErrorState(
          message: state.errorMessage ?? 'Error desconocido',
          onRetry: () => context.read<ChildrenListCubit>().loadData(),
        );

      case ChildrenListStatus.loaded:
        final children = state.children;
        if (children.isEmpty) {
          return const EmptyState(
            icon: Icons.child_care_outlined,
            message: 'No hay alumnos registrados.',
          );
        }

        final filtered = _filtered(state.filteredChildren);

        return RefreshIndicator(
          onRefresh: () => context.read<ChildrenListCubit>().refresh(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Title row with filter + search toggle icons
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
                  child: Row(
                    children: [
                      Text(
                        'Alumnos',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                      ),
                      const Spacer(),
                      // Filter icon
                      IconButton(
                        onPressed: () => setState(() => _showFilters = !_showFilters),
                        icon: Icon(
                          _showFilters ? Icons.filter_list_off : Icons.filter_list,
                          color: _showFilters
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade500,
                        ),
                        tooltip: 'Filtrar por aula',
                        visualDensity: VisualDensity.compact,
                      ),
                      // Search icon
                      IconButton(
                        onPressed: () => setState(() {
                          _showSearch = !_showSearch;
                          if (!_showSearch) {
                            _searchController.clear();
                            _searchQuery = '';
                          }
                        }),
                        icon: Icon(
                          _showSearch ? Icons.search_off : Icons.search,
                          color: _showSearch
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade500,
                        ),
                        tooltip: 'Buscar',
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
              ),

              // -- Classroom selector pills (collapsible) --
              if (_showFilters && state.classrooms.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: SizedBox(
                      height: 38,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _ClassroomPill(
                            label: 'Todos',
                            count: state.children.length,
                            isSelected: state.selectedClassroomId == null,
                            onTap: () => context.read<ChildrenListCubit>().selectClassroom(null),
                          ),
                          const SizedBox(width: 6),
                          ...state.classrooms.map((classroom) {
                            final count = state.childCountForClassroom(classroom.id!);
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: _ClassroomPill(
                                label: classroom.name,
                                count: count,
                                isSelected: state.selectedClassroomId == classroom.id,
                                onTap: () => context.read<ChildrenListCubit>().selectClassroom(classroom.id),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),

              // Search bar (collapsible)
              if (_showSearch)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Buscar alumno...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Count + bulk habit button
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        '${filtered.length} alumno${filtered.length == 1 ? '' : 's'}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      if (context.read<AuthCubit>().state.isStaffOrAbove && filtered.isNotEmpty) ...[
                        _BulkIconBtn(
                          emoji: '🍽️',
                          color: const Color(0xFFFF8A65),
                          tooltip: 'Comida masiva',
                          onTap: () {
                            final gn = state.selectedClassroomId == null
                                ? 'todos los alumnos'
                                : state.classrooms.where((c) => c.id == state.selectedClassroomId).map((c) => c.name).firstOrNull ?? 'esta clase';
                            _openBulkMeal(context, filtered, gn);
                          },
                        ),
                        const SizedBox(width: 4),
                        _BulkIconBtn(
                          emoji: '😴',
                          color: const Color(0xFF7986CB),
                          tooltip: 'Siesta masiva',
                          onTap: () {
                            final gn = state.selectedClassroomId == null
                                ? 'todos los alumnos'
                                : state.classrooms.where((c) => c.id == state.selectedClassroomId).map((c) => c.name).firstOrNull ?? 'esta clase';
                            _openBulkNap(context, filtered, gn);
                          },
                        ),
                        const SizedBox(width: 4),
                        _BulkIconBtn(
                          emoji: '🚽',
                          color: const Color(0xFF4DB6AC),
                          tooltip: 'Deposición masiva',
                          onTap: () {
                            final gn = state.selectedClassroomId == null
                                ? 'todos los alumnos'
                                : state.classrooms.where((c) => c.id == state.selectedClassroomId).map((c) => c.name).firstOrNull ?? 'esta clase';
                            _openBulkBowel(context, filtered, gn);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Grid
              if (filtered.isEmpty)
                const SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.search_off,
                    message: 'Sin resultados para esta búsqueda.',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount =
                          constraints.crossAxisExtent > 600 ? 2 : 1;
                      return SliverGrid(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 136,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final child = filtered[index];
                            return _ChildCard(
                              child: child,
                              age: _ageFromDob(child.dateOfBirth),
                              onTap: () =>
                                  context.go('/children/${child.id}'),
                              onMeal: () =>
                                  _openMealForm(context, child),
                              onNap: () =>
                                  _openNapForm(context, child),
                              onBowel: () =>
                                  _openBowelForm(context, child),
                            );
                          },
                          childCount: filtered.length,
                        ),
                      );
                    },
                  ),
                ),

              // Bottom padding for FAB
              const SliverToBoxAdapter(
                child: SizedBox(height: 88),
              ),
            ],
          ),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Classroom selector pill
// ---------------------------------------------------------------------------
class _ClassroomPill extends StatelessWidget {
  const _ClassroomPill({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? primary : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.25)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Child card with quick actions
// ---------------------------------------------------------------------------
class _ChildCard extends StatelessWidget {
  const _ChildCard({
    required this.child,
    required this.age,
    required this.onTap,
    required this.onMeal,
    required this.onNap,
    required this.onBowel,
  });

  final Child child;
  final String age;
  final VoidCallback onTap;
  final VoidCallback onMeal;
  final VoidCallback onNap;
  final VoidCallback onBowel;

  @override
  Widget build(BuildContext context) {
    final name = '${child.firstName} ${child.lastName}';

    return GiciCard(
      onTap: onTap,
      child: Row(
        children: [
          GiciAvatar(name: name, radius: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  age,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                // Quick action row
                Row(
                  children: [
                    _QuickActionButton(
                      icon: Icons.restaurant_rounded,
                      color: const Color(0xFFFF8A65),
                      tooltip: 'Comida',
                      onTap: onMeal,
                    ),
                    const SizedBox(width: 8),
                    _QuickActionButton(
                      icon: Icons.bedtime_rounded,
                      color: const Color(0xFF7986CB),
                      tooltip: 'Siesta',
                      onTap: onNap,
                    ),
                    const SizedBox(width: 8),
                    _QuickActionButton(
                      icon: Icons.baby_changing_station_rounded,
                      color: const Color(0xFF4DB6AC),
                      tooltip: 'Deposición',
                      onTap: onBowel,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small quick action icon button
// ---------------------------------------------------------------------------
class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 34,
            height: 34,
            child: Icon(icon, size: 18, color: color),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sticky search bar delegate
// ---------------------------------------------------------------------------
class _StickySearchDelegate extends SliverPersistentHeaderDelegate {
  _StickySearchDelegate({
    required this.controller,
    required this.onChanged,
    required this.query,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String query;
  final VoidCallback onClear;

  @override
  double get minExtent => 68;
  @override
  double get maxExtent => 68;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFFF5F5F7),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar alumno...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded, color: Colors.grey.shade400),
                  onPressed: onClear,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickySearchDelegate oldDelegate) =>
      query != oldDelegate.query;
}

// ---------------------------------------------------------------------------
// Bulk icon button
// ---------------------------------------------------------------------------

class _BulkIconBtn extends StatelessWidget {
  const _BulkIconBtn({
    required this.emoji,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  final String emoji;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 16))),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bulk wrappers — open the standard form, then apply result to all children
// ---------------------------------------------------------------------------

class _BulkMealWrapper extends StatelessWidget {
  const _BulkMealWrapper({required this.children, required this.habitRepo});
  final List<Child> children;
  final HabitRepository habitRepo;

  @override
  Widget build(BuildContext context) {
    return MealFormPage(
      onBulkSave: (mealType, consumptionLevel, recordedAt, menuItems, notes) async {
        for (final child in children) {
          await habitRepo.createMealEntry(
            childId: child.id!,
            mealType: mealType,
            consumptionLevel: consumptionLevel,
            recordedAt: recordedAt,
            menuItems: menuItems,
            notes: notes,
          );
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Comida registrada para ${children.length} alumnos')),
          );
          Navigator.of(context).pop(true);
        }
      },
    );
  }
}

class _BulkNapWrapper extends StatelessWidget {
  const _BulkNapWrapper({required this.children, required this.habitRepo});
  final List<Child> children;
  final HabitRepository habitRepo;

  @override
  Widget build(BuildContext context) {
    return NapFormPage(
      onBulkSave: (startedAt, endedAt, durationMinutes, sleepQuality, notes) async {
        for (final child in children) {
          await habitRepo.createNapEntry(
            childId: child.id!,
            startedAt: startedAt,
            endedAt: endedAt,
            durationMinutes: durationMinutes,
            sleepQuality: sleepQuality,
            notes: notes,
          );
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Siesta registrada para ${children.length} alumnos')),
          );
          Navigator.of(context).pop(true);
        }
      },
    );
  }
}

class _BulkBowelWrapper extends StatelessWidget {
  const _BulkBowelWrapper({required this.children, required this.habitRepo});
  final List<Child> children;
  final HabitRepository habitRepo;

  @override
  Widget build(BuildContext context) {
    return BowelFormPage(
      onBulkSave: (eventType, eventAt, consistency, notes) async {
        for (final child in children) {
          await habitRepo.createBowelMovementEntry(
            childId: child.id!,
            eventType: eventType,
            eventAt: eventAt,
            consistency: consistency,
            notes: notes,
          );
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Deposición registrada para ${children.length} alumnos')),
          );
          Navigator.of(context).pop(true);
        }
      },
    );
  }
}
