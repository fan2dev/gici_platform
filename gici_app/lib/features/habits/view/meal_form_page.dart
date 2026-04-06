import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../cubit/habits_cubit.dart';

/// Form page for creating or editing a meal entry.
///
/// When [existingMeal] is provided, the form enters edit mode.
class MealFormPage extends StatefulWidget {
  const MealFormPage({this.existingMeal, super.key});

  final MealEntry? existingMeal;

  @override
  State<MealFormPage> createState() => _MealFormPageState();
}

class _MealFormPageState extends State<MealFormPage> {
  final _formKey = GlobalKey<FormState>();

  late String _mealType;
  late String _consumptionLevel;
  late DateTime _recordedAt;
  late TextEditingController _notesController;
  late TextEditingController _menuItemsController;

  bool get _isEditing => widget.existingMeal != null;

  static const _mealTypes = [
    ('breakfast', 'Desayuno'),
    ('lunch', 'Almuerzo'),
    ('snack', 'Merienda'),
    ('dinner', 'Cena'),
  ];

  static const _consumptionLevels = [
    ('none', 'Nada'),
    ('little', 'Poco'),
    ('half', 'Mitad'),
    ('most', 'Casi todo'),
    ('all', 'Todo'),
  ];

  @override
  void initState() {
    super.initState();
    final meal = widget.existingMeal;
    _mealType = meal?.mealType ?? 'lunch';
    _consumptionLevel = meal?.consumptionLevel ?? 'most';
    _recordedAt = meal?.recordedAt ?? DateTime.now().toUtc();
    _notesController = TextEditingController(text: meal?.notes ?? '');
    _menuItemsController = TextEditingController(text: meal?.menuItems ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    _menuItemsController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _recordedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_recordedAt),
    );
    if (time == null || !mounted) return;

    setState(() {
      _recordedAt = DateTime.utc(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<HabitsCubit>();
    final notes =
        _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final menuItems = _menuItemsController.text.trim().isEmpty
        ? null
        : _menuItemsController.text.trim();

    bool success;
    if (_isEditing) {
      success = await cubit.updateMeal(
        mealEntryId: widget.existingMeal!.id!,
        mealType: _mealType,
        consumptionLevel: _consumptionLevel,
        recordedAt: _recordedAt,
        menuItems: menuItems,
        notes: notes,
      );
    } else {
      success = await cubit.createMeal(
        mealType: _mealType,
        consumptionLevel: _consumptionLevel,
        recordedAt: _recordedAt,
        menuItems: menuItems,
        notes: notes,
      );
    }

    if (success && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Comida' : 'Nueva Comida'),
      ),
      body: BlocBuilder<HabitsCubit, HabitsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _mealType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de comida',
                      border: OutlineInputBorder(),
                    ),
                    items: _mealTypes
                        .map((t) => DropdownMenuItem(
                              value: t.$1,
                              child: Text(t.$2),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _mealType = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _consumptionLevel,
                    decoration: const InputDecoration(
                      labelText: 'Nivel de consumo',
                      border: OutlineInputBorder(),
                    ),
                    items: _consumptionLevels
                        .map((t) => DropdownMenuItem(
                              value: t.$1,
                              child: Text(t.$2),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _consumptionLevel = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.access_time),
                    title: const Text('Fecha y hora'),
                    subtitle: Text(
                      '${_recordedAt.day.toString().padLeft(2, '0')}/'
                      '${_recordedAt.month.toString().padLeft(2, '0')}/'
                      '${_recordedAt.year}  '
                      '${_recordedAt.hour.toString().padLeft(2, '0')}:'
                      '${_recordedAt.minute.toString().padLeft(2, '0')}',
                    ),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: _pickDateTime,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _menuItemsController,
                    decoration: const InputDecoration(
                      labelText: 'Menu / Alimentos',
                      border: OutlineInputBorder(),
                    ),
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notas',
                      border: OutlineInputBorder(),
                    ),
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: state.isSaving ? null : _save,
                    child: state.isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_isEditing ? 'Guardar cambios' : 'Crear'),
                  ),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
