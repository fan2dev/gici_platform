import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
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
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Centro',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/direccion'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: canManageMenu
          ? FloatingActionButton(
              onPressed: () => _showMenuEntryForm(context),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.restaurant_menu, color: Colors.white),
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
                  const SectionHeader(
                    title: 'Información del centro',
                    icon: '\u{1F3EB}',
                  ),
                  GiciCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.centerInfo!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.centerInfo!.slug,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          emoji: '\u2709\uFE0F',
                          label: 'Email',
                          value: state.centerInfo!.contactEmail,
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                // Onboarding section
                const SectionHeader(
                  title: 'Configuración inicial',
                  icon: '\u{1F680}',
                ),
                GiciCard(
                  accentColor: state.isOnboardingComplete
                      ? Colors.green
                      : Colors.orange,
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: state.isOnboardingComplete
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          state.isOnboardingComplete
                              ? Icons.check_circle
                              : Icons.pending,
                          color: state.isOnboardingComplete
                              ? Colors.green
                              : Colors.orange,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.isOnboardingComplete
                                  ? 'Configuración completada'
                                  : 'Configuración pendiente',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              state.isOnboardingComplete
                                  ? 'Completado el ${state.onboardingState!.completedAt!.toIso8601String().substring(0, 10)}'
                                  : 'Acepta los términos para completar',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!state.isOnboardingComplete)
                        FilledButton(
                          onPressed: () => context
                              .read<ExperienceCubit>()
                              .completeOnboarding(),
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text('Completar',
                              style: TextStyle(fontSize: 12)),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Menu editor link (admin only)
                if (canManageMenu) ...[
                  const SectionHeader(
                    title: 'Gesti\u00f3n de men\u00fas',
                    icon: '\u{1F4CB}',
                  ),
                  GiciCard(
                    onTap: () => context.go('/menu-editor'),
                    accentColor: const Color(0xFFFB8C00),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFB8C00).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xFFFB8C00),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Editor de men\u00fas mensuales',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Subir y editar men\u00fas por mes',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                // Menu section
                SectionHeader(
                  title: 'Men\u00fa diario',
                  icon: '\u{1F37D}\uFE0F',
                  action: state.menuEntries.isNotEmpty
                      ? StatusPill(
                          label: '${state.menuEntries.length} entradas',
                          small: true,
                        )
                      : null,
                ),

                if (state.menuEntries.isEmpty)
                  GiciCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant_outlined,
                          size: 40,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No hay entradas de menú',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ..._buildGroupedMenuEntries(
                    context,
                    state.menuEntries,
                  ),

                const SizedBox(height: 80),
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
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: Text(
            formattedDate,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );

      for (final entry in dateEntries) {
        widgets.add(
          GiciCard(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _mealColor(entry.mealType).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _mealEmoji(entry.mealType),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _mealLabel(entry.mealType),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      if (entry.description != null &&
                          entry.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          entry.description!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return widgets;
  }

  String _mealEmoji(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return '\u{1F963}';
      case 'lunch':
        return '\u{1F37D}\uFE0F';
      case 'snack':
        return '\u{1F34E}';
      case 'dinner':
        return '\u{1F37D}\uFE0F';
      default:
        return '\u{1F374}';
    }
  }

  Color _mealColor(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.green;
      case 'snack':
        return Colors.purple;
      case 'dinner':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _mealLabel(String mealType) {
    switch (mealType) {
      case 'bottle':
        return 'Biberón';
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
      case 'dinner':
        return 'Cena';
      default:
        return mealType;
    }
  }

  void _showMenuEntryForm(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String mealType = 'lunch_first';
    String menuTrack = 'normal';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'Nueva entrada de men\u00fa',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'T\u00edtulo *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripci\u00f3n',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: menuTrack,
                    decoration: InputDecoration(
                      labelText: 'Tipo de men\u00fa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'normal', child: Text('Men\u00fa Normal')),
                      DropdownMenuItem(
                          value: 'menu2', child: Text('Men\u00fa 2 (Triturado)')),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        setDialogState(() => menuTrack = v);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: mealType,
                    decoration: InputDecoration(
                      labelText: 'Tipo de comida',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'lunch_first', child: Text('Primer plato')),
                      DropdownMenuItem(
                          value: 'lunch_second', child: Text('Segundo plato')),
                      DropdownMenuItem(
                          value: 'dessert', child: Text('Postre')),
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
                          menuTrack: menuTrack,
                        );
                    Navigator.of(dialogContext).pop();
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
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
    required this.emoji,
    required this.label,
    required this.value,
  });

  final String emoji;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
