import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../children/data/child_repository.dart';
import '../data/habit_repository.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  UuidValue? _selectedChildId;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final childRepo = sl<ChildRepository>();
    final habitRepo = sl<HabitRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracking'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<Child>>(
        future: childRepo.listChildren(
          page: 0,
          pageSize: 100,
        ),
        builder: (context, childrenSnapshot) {
          if (childrenSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (childrenSnapshot.hasError) {
            return Center(
              child: Text('Child load error: ${childrenSnapshot.error}'),
            );
          }

          final children = childrenSnapshot.data ?? const <Child>[];
          if (children.isEmpty) {
            return const Center(child: Text('No children available.'));
          }

          _selectedChildId ??= children.first.id;
          final selected = children.firstWhere(
            (c) => c.id == _selectedChildId,
            orElse: () => children.first,
          );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<UuidValue>(
                  value: selected.id,
                  decoration: const InputDecoration(labelText: 'Child'),
                  items: children
                      .map(
                        (c) => DropdownMenuItem<UuidValue>(
                          value: c.id,
                          child: Text('${c.firstName} ${c.lastName}'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedChildId = value);
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<ChildDailyHabits>(
                  future: habitRepo.getChildDailyHabits(
                    childId: selected.id!,
                    day: DateTime.now().toUtc(),
                  ),
                  builder: (context, dailySnapshot) {
                    if (dailySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (dailySnapshot.hasError || dailySnapshot.data == null) {
                      return Center(
                        child: Text('Habit load error: ${dailySnapshot.error}'),
                      );
                    }

                    final daily = dailySnapshot.data!;
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        if (canManage)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              FilledButton(
                                onPressed: () async {
                                  await habitRepo.createMealEntry(
                                    childId: selected.id!,
                                    mealType: 'lunch',
                                    consumptionLevel: 'most',
                                    notes: 'Quick meal entry',
                                  );
                                  if (mounted) setState(() {});
                                },
                                child: const Text('Quick meal'),
                              ),
                              FilledButton(
                                onPressed: () async {
                                  final now = DateTime.now().toUtc();
                                  await habitRepo.createNapEntry(
                                    childId: selected.id!,
                                    startedAt: now.subtract(
                                      const Duration(minutes: 45),
                                    ),
                                    endedAt: now,
                                    durationMinutes: 45,
                                    notes: 'Quick nap entry',
                                  );
                                  if (mounted) setState(() {});
                                },
                                child: const Text('Quick nap'),
                              ),
                              FilledButton(
                                onPressed: () async {
                                  await habitRepo.createBowelMovementEntry(
                                    childId: selected.id!,
                                    eventType: 'diaper_change',
                                    consistency: 'normal',
                                    notes: 'Quick diaper event',
                                  );
                                  if (mounted) setState(() {});
                                },
                                child: const Text('Quick diaper event'),
                              ),
                            ],
                          ),
                        if (canManage) const SizedBox(height: 16),
                        Text(
                          'Meals',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        if (daily.meals.isEmpty)
                          const Text('No meals recorded today.')
                        else
                          ...daily.meals.map(
                            (m) => ListTile(
                              title: Text(
                                '${m.mealType} • ${m.consumptionLevel}',
                              ),
                              subtitle: Text(
                                m.notes ?? m.recordedAt.toIso8601String(),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'Naps',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        if (daily.naps.isEmpty)
                          const Text('No naps recorded today.')
                        else
                          ...daily.naps.map(
                            (n) => ListTile(
                              title: Text(
                                'Nap • ${n.durationMinutes ?? '-'} min',
                              ),
                              subtitle: Text(
                                n.notes ?? n.startedAt.toIso8601String(),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'Bowel / diaper',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        if (daily.bowelMovements.isEmpty)
                          const Text('No bowel/diaper events recorded today.')
                        else
                          ...daily.bowelMovements.map(
                            (b) => ListTile(
                              title: Text(b.eventType),
                              subtitle: Text(
                                b.notes ?? b.eventAt.toIso8601String(),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
