import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../cubit/habits_cubit.dart';

/// Form page for creating or editing a bowel movement / diaper entry.
class BowelFormPage extends StatefulWidget {
  const BowelFormPage({this.existingEntry, super.key});

  final BowelMovementEntry? existingEntry;

  @override
  State<BowelFormPage> createState() => _BowelFormPageState();
}

class _BowelFormPageState extends State<BowelFormPage> {
  final _formKey = GlobalKey<FormState>();

  late String _eventType;
  late DateTime _eventAt;
  late String? _consistency;
  late TextEditingController _notesController;

  bool get _isEditing => widget.existingEntry != null;

  static const _eventTypes = [
    ('diaper_change', 'Cambio de panal'),
    ('toilet', 'Inodoro'),
  ];

  static const _consistencies = [
    ('normal', 'Normal'),
    ('soft', 'Blanda'),
    ('hard', 'Dura'),
    ('liquid', 'Liquida'),
  ];

  @override
  void initState() {
    super.initState();
    final entry = widget.existingEntry;
    _eventType = entry?.eventType ?? 'diaper_change';
    _eventAt = entry?.eventAt ?? DateTime.now().toUtc();
    _consistency = entry?.consistency;
    _notesController = TextEditingController(text: entry?.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _eventAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_eventAt),
    );
    if (time == null || !mounted) return;

    setState(() {
      _eventAt = DateTime.utc(
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

    bool success;
    if (_isEditing) {
      success = await cubit.updateBowel(
        entryId: widget.existingEntry!.id!,
        eventAt: _eventAt,
        eventType: _eventType,
        consistency: _consistency,
        notes: notes,
      );
    } else {
      success = await cubit.createBowel(
        eventType: _eventType,
        eventAt: _eventAt,
        consistency: _consistency,
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
        title: Text(_isEditing ? 'Editar Deposicion' : 'Nueva Deposicion'),
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
                    value: _eventType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de evento',
                      border: OutlineInputBorder(),
                    ),
                    items: _eventTypes
                        .map((t) => DropdownMenuItem(
                              value: t.$1,
                              child: Text(t.$2),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _eventType = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _consistency,
                    decoration: const InputDecoration(
                      labelText: 'Consistencia',
                      border: OutlineInputBorder(),
                    ),
                    items: _consistencies
                        .map((c) => DropdownMenuItem(
                              value: c.$1,
                              child: Text(c.$2),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _consistency = v),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.access_time),
                    title: const Text('Fecha y hora'),
                    subtitle: Text(
                      '${_eventAt.day.toString().padLeft(2, '0')}/'
                      '${_eventAt.month.toString().padLeft(2, '0')}/'
                      '${_eventAt.year}  '
                      '${_eventAt.hour.toString().padLeft(2, '0')}:'
                      '${_eventAt.minute.toString().padLeft(2, '0')}',
                    ),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: _pickDateTime,
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
