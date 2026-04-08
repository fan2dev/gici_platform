import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/section_header.dart';
import '../cubit/habits_cubit.dart';

/// Form page for creating or editing a meal entry.
///
/// When [existingMeal] is provided, the form enters edit mode.
class MealFormPage extends StatefulWidget {
  const MealFormPage({this.existingMeal, this.onBulkSave, super.key});

  final MealEntry? existingMeal;
  final Future<void> Function(String mealType, String consumptionLevel, DateTime? recordedAt, String? menuItems, String? notes)? onBulkSave;

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
    ('bottle', 'Biberon', Icons.baby_changing_station_rounded),
    ('breakfast', 'Desayuno', Icons.free_breakfast_rounded),
    ('lunch', 'Comida', Icons.lunch_dining_rounded),
    ('snack', 'Merienda', Icons.cookie_rounded),
  ];

  static const _consumptionLevels = [
    ('little', 'Poco', Color(0xFFFF7043)),
    ('most', 'Bastante', Color(0xFFFFA726)),
    ('all', 'Todo', Color(0xFF43A047)),
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

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_recordedAt.toLocal()),
    );
    if (time == null || !mounted) return;

    final now = DateTime.now();
    setState(() {
      _recordedAt = DateTime.utc(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final notes =
        _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final menuItems = _menuItemsController.text.trim().isEmpty
        ? null
        : _menuItemsController.text.trim();

    // Bulk save mode
    if (widget.onBulkSave != null) {
      await widget.onBulkSave!(_mealType, _consumptionLevel, _recordedAt, menuItems, notes);
      return;
    }

    final cubit = context.read<HabitsCubit>();
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
    final primary = Theme.of(context).colorScheme.primary;
    final localTime = _recordedAt.toLocal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Comida' : 'Nueva Comida',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: BlocBuilder<HabitsCubit, HabitsState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: state.isSaving ? null : _save,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: state.isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(_isEditing ? 'Guardar cambios' : 'Registrar'),
                ),
              ),
            ),
          );
        },
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
                  // Meal type: 4 large selectable cards
                  const SectionHeader(title: 'Tipo de comida'),
                  Row(
                    children: _mealTypes.map((t) {
                      final selected = _mealType == t.$1;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: t != _mealTypes.last ? 8 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () => setState(() => _mealType = t.$1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: selected
                                    ? primary.withValues(alpha: 0.08)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: selected ? primary : Colors.grey.shade200,
                                  width: selected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    t.$3,
                                    size: 28,
                                    color: selected ? primary : Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    t.$2,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: selected ? primary : Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Consumption: 3 large quick-tap buttons
                  const SectionHeader(title: 'Consumo'),
                  Row(
                    children: _consumptionLevels.map((level) {
                      final selected = _consumptionLevel == level.$1;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: level != _consumptionLevels.last ? 10 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _consumptionLevel = level.$1),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                color: selected
                                    ? level.$3.withValues(alpha: 0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: selected
                                      ? level.$3
                                      : Colors.grey.shade200,
                                  width: selected ? 2.5 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  level.$2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: selected
                                        ? level.$3
                                        : Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Time picker tile — defaults to NOW, tappable
                  GiciCard(
                    onTap: _pickTime,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            color: primary, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hora',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '${localTime.hour.toString().padLeft(2, '0')}:'
                                '${localTime.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.edit_rounded,
                            size: 18, color: Colors.grey.shade400),
                      ],
                    ),
                  ),

                  // Notes field
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'Notas (opcional)',
                      hintText: 'Observaciones sobre la comida...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: primary, width: 1.5),
                      ),
                    ),
                    minLines: 2,
                    maxLines: 4,
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

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
