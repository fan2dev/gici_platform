import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../cubit/habits_cubit.dart';

/// Form page for creating or editing a nap entry.
class NapFormPage extends StatefulWidget {
  const NapFormPage({this.existingNap, super.key});

  final NapEntry? existingNap;

  @override
  State<NapFormPage> createState() => _NapFormPageState();
}

class _NapFormPageState extends State<NapFormPage> {
  final _formKey = GlobalKey<FormState>();

  late DateTime _startedAt;
  late DateTime? _endedAt;
  late TextEditingController _durationController;
  late String? _sleepQuality;
  late TextEditingController _notesController;

  bool get _isEditing => widget.existingNap != null;

  static const _qualities = [
    ('good', 'Buena'),
    ('fair', 'Regular'),
    ('poor', 'Mala'),
    ('restless', 'Inquieto'),
  ];

  @override
  void initState() {
    super.initState();
    final nap = widget.existingNap;
    _startedAt = nap?.startedAt ?? DateTime.now().toUtc();
    _endedAt = nap?.endedAt;
    _durationController = TextEditingController(
      text: nap?.durationMinutes?.toString() ?? '',
    );
    _sleepQuality = nap?.sleepQuality;
    _notesController = TextEditingController(text: nap?.notes ?? '');
  }

  @override
  void dispose() {
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;

    return DateTime.utc(date.year, date.month, date.day, time.hour, time.minute);
  }

  String _formatDt(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.year}  '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<HabitsCubit>();
    final notes =
        _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final duration = int.tryParse(_durationController.text.trim());

    bool success;
    if (_isEditing) {
      success = await cubit.updateNap(
        napEntryId: widget.existingNap!.id!,
        startedAt: _startedAt,
        endedAt: _endedAt,
        durationMinutes: duration,
        sleepQuality: _sleepQuality,
        notes: notes,
      );
    } else {
      success = await cubit.createNap(
        startedAt: _startedAt,
        endedAt: _endedAt,
        durationMinutes: duration,
        sleepQuality: _sleepQuality,
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
        title: Text(_isEditing ? 'Editar Siesta' : 'Nueva Siesta'),
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
                  // Started at
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.bedtime),
                    title: const Text('Inicio'),
                    subtitle: Text(_formatDt(_startedAt)),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: () async {
                      final dt = await _pickDateTime(_startedAt);
                      if (dt != null) setState(() => _startedAt = dt);
                    },
                  ),
                  const Divider(),
                  // Ended at
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.wb_sunny_outlined),
                    title: const Text('Fin'),
                    subtitle: Text(
                      _endedAt != null ? _formatDt(_endedAt!) : 'Sin registrar',
                    ),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: () async {
                      final dt = await _pickDateTime(_endedAt ?? _startedAt);
                      if (dt != null) setState(() => _endedAt = dt);
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duracion (minutos)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _sleepQuality,
                    decoration: const InputDecoration(
                      labelText: 'Calidad del sueno',
                      border: OutlineInputBorder(),
                    ),
                    items: _qualities
                        .map((q) => DropdownMenuItem(
                              value: q.$1,
                              child: Text(q.$2),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _sleepQuality = v),
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
