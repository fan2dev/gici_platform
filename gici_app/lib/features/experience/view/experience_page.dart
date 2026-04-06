import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/experience_cubit.dart';
import '../data/experience_repository.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ExperienceCubit(sl<ExperienceRepository>())..load(),
      child: const _ExperienceView(),
    );
  }
}

class _ExperienceView extends StatelessWidget {
  const _ExperienceView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final canManageMenu = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: canManageMenu
          ? FloatingActionButton.extended(
              onPressed: () => _showMenuEntryForm(context),
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Nuevo menu'),
            )
          : null,
      body: BlocBuilder<ExperienceCubit, ExperienceState>(
        builder: (context, state) {
          if (state.status == ExperienceStatus.loading) {
            return const LoadingState(message: 'Cargando...');
          }
          if (state.status == ExperienceStatus.error) {
            return ErrorState(
              message: state.errorMessage ?? 'Error al cargar datos',
              onRetry: () => context.read<ExperienceCubit>().load(),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<ExperienceCubit>().load(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Center info card
                if (state.centerInfo != null) ...[
                  Text(
                    'Informacion del centro',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                child: Text(
                                  state.centerInfo!.name.isNotEmpty
                                      ? state.centerInfo!.name[0]
                                          .toUpperCase()
                                      : '?',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.centerInfo!.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      state.centerInfo!.slug,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          _InfoRow(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: state.centerInfo!.contactEmail,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Onboarding section
                Text(
                  'Onboarding',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: state.isOnboardingComplete
                          ? Colors.green
                          : Colors.orange,
                      child: Icon(
                        state.isOnboardingComplete
                            ? Icons.check
                            : Icons.pending,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      state.isOnboardingComplete
                          ? 'Onboarding completado'
                          : 'Onboarding pendiente',
                    ),
                    subtitle: Text(
                      state.isOnboardingComplete
                          ? 'Completado el ${state.onboardingState!.completedAt!.toIso8601String().substring(0, 10)}'
                          : 'Acepta los terminos para completar',
                    ),
                    trailing: !state.isOnboardingComplete
                        ? FilledButton(
                            onPressed: () => context
                                .read<ExperienceCubit>()
                                .completeOnboarding(),
                            child: const Text('Completar'),
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 24),

                // Menu section
                Row(
                  children: [
                    Text(
                      'Menu diario',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    if (state.menuEntries.isNotEmpty)
                      Text(
                        '${state.menuEntries.length} entradas',
                        style:
                            Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                if (state.menuEntries.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant_outlined,
                            size: 48,
                            color: Theme.of(context)
                                .colorScheme
                                .outline,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No hay entradas de menu',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outline,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ..._buildGroupedMenuEntries(
                    context,
                    state.menuEntries,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildGroupedMenuEntries(
    BuildContext context,
    List<dynamic> entries,
  ) {
    final dateFormat = DateFormat('EEEE, d MMMM', 'es');
    final grouped = <String, List<dynamic>>{};

    for (final entry in entries) {
      final key = entry.menuDate.toIso8601String().substring(0, 10);
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    final widgets = <Widget>[];
    for (final key in sortedKeys) {
      final dateEntries = grouped[key]!;
      String formattedDate;
      try {
        formattedDate = dateFormat.format(DateTime.parse(key));
      } catch (_) {
        formattedDate = key;
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(
            formattedDate,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      );

      for (final entry in dateEntries) {
        widgets.add(
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(_mealIcon(entry.mealType)),
              ),
              title: Text(entry.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _mealLabel(entry.mealType),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (entry.description != null &&
                      entry.description!.isNotEmpty)
                    Text(
                      entry.description!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  IconData _mealIcon(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'snack':
        return Icons.cookie;
      case 'dinner':
        return Icons.dinner_dining;
      default:
        return Icons.restaurant;
    }
  }

  String _mealLabel(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return 'Desayuno';
      case 'lunch':
        return 'Almuerzo';
      case 'snack':
        return 'Merienda';
      case 'dinner':
        return 'Cena';
      default:
        return mealType;
    }
  }

  void _showMenuEntryForm(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String mealType = 'lunch';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Nueva entrada de menu'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titulo *',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripcion',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: mealType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de comida',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'breakfast',
                        child: Text('Desayuno'),
                      ),
                      DropdownMenuItem(
                        value: 'lunch',
                        child: Text('Almuerzo'),
                      ),
                      DropdownMenuItem(
                        value: 'snack',
                        child: Text('Merienda'),
                      ),
                      DropdownMenuItem(
                        value: 'dinner',
                        child: Text('Cena'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        setDialogState(() => mealType = v);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isEmpty) return;
                    context.read<ExperienceCubit>().createMenuEntry(
                          menuDate: DateTime.now().toUtc(),
                          mealType: mealType,
                          title: title,
                          description:
                              descriptionController.text.trim().isEmpty
                                  ? null
                                  : descriptionController.text.trim(),
                        );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Crear'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
