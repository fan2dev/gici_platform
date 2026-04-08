import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/section_header.dart';
import '../cubit/habits_cubit.dart';

/// Form page for creating or editing a nap entry.
class NapFormPage extends StatefulWidget {
  const NapFormPage({this.existingNap, this.onBulkSave, super.key});

  final NapEntry? existingNap;
  final Future<void> Function(DateTime startedAt, DateTime? endedAt, int? durationMinutes, String? sleepQuality, String? notes)? onBulkSave;

  @override
  State<NapFormPage> createState() => _NapFormPageState();
}

class _NapFormPageState extends State<NapFormPage> {
  final _formKey = GlobalKey<FormState>();

  late DateTime _startedAt;
  late DateTime? _endedAt;
  late String? _sleepQuality;
  late TextEditingController _notesController;

  bool get _isEditing => widget.existingNap != null;

  static const _qualities = [
    ('good', 'Buena', Icons.sentiment_very_satisfied_rounded, Color(0xFF43A047)),
    ('fair', 'Regular', Icons.sentiment_neutral_rounded, Color(0xFFFFA726)),
    ('poor', 'Mala', Icons.sentiment_very_dissatisfied_rounded, Color(0xFFE53935)),
  ];

  @override
  void initState() {
    super.initState();
    final nap = widget.existingNap;
    _startedAt = nap?.startedAt ?? DateTime.now().toUtc();
    _endedAt = nap?.endedAt;
    _sleepQuality = nap?.sleepQuality;
    _notesController = TextEditingController(text: nap?.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startedAt.toLocal()),
    );
    if (time == null || !mounted) return;

    final now = DateTime.now();
    setState(() {
      _startedAt = DateTime.utc(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _pickEndTime() async {
    final initial = _endedAt ?? _startedAt;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial.toLocal()),
    );
    if (time == null || !mounted) return;

    final now = DateTime.now();
    setState(() {
      _endedAt = DateTime.utc(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
    });
  }

  int? get _autoCalcDuration {
    if (_endedAt == null) return null;
    final diff = _endedAt!.difference(_startedAt).inMinutes;
    return diff > 0 ? diff : null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final notes =
        _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final duration = _autoCalcDuration;

    if (widget.onBulkSave != null) {
      await widget.onBulkSave!(_startedAt, _endedAt, duration, _sleepQuality, notes);
      return;
    }

    final cubit = context.read<HabitsCubit>();
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
    final primary = Theme.of(context).colorScheme.primary;
    final localStart = _startedAt.toLocal();
    final localEnd = _endedAt?.toLocal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Siesta' : 'Nueva Siesta',
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
                  // Start time
                  const SectionHeader(title: 'Horario'),
                  GiciCard(
                    onTap: _pickStartTime,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.bedtime_rounded,
                            color: primary, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Inicio',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '${localStart.hour.toString().padLeft(2, '0')}:'
                                '${localStart.minute.toString().padLeft(2, '0')}',
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

                  // End time (optional)
                  GiciCard(
                    onTap: _pickEndTime,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(Icons.wb_sunny_rounded,
                            color: const Color(0xFFFFA726), size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fin (opcional)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                localEnd != null
                                    ? '${localEnd.hour.toString().padLeft(2, '0')}:'
                                      '${localEnd.minute.toString().padLeft(2, '0')}'
                                    : 'Sin registrar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: localEnd != null
                                      ? Colors.black87
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_endedAt != null)
                          GestureDetector(
                            onTap: () => setState(() => _endedAt = null),
                            child: Icon(Icons.close_rounded,
                                size: 18, color: Colors.grey.shade400),
                          )
                        else
                          Icon(Icons.edit_rounded,
                              size: 18, color: Colors.grey.shade400),
                      ],
                    ),
                  ),

                  // Auto-calculated duration
                  if (_autoCalcDuration != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_outlined,
                                size: 20, color: primary),
                            const SizedBox(width: 8),
                            Text(
                              'Duracion: $_autoCalcDuration min',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: primary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 4),

                  // Quality: 3 quick-tap buttons
                  const SectionHeader(title: 'Calidad del sueno'),
                  Row(
                    children: _qualities.map((q) {
                      final selected = _sleepQuality == q.$1;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: q != _qualities.last ? 10 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _sleepQuality = q.$1),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                color: selected
                                    ? q.$4.withValues(alpha: 0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: selected
                                      ? q.$4
                                      : Colors.grey.shade200,
                                  width: selected ? 2.5 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    q.$3,
                                    size: 28,
                                    color: selected
                                        ? q.$4
                                        : Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    q.$2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: selected
                                          ? q.$4
                                          : Colors.grey.shade500,
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

                  // Notes
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'Notas (opcional)',
                      hintText: 'Observaciones sobre la siesta...',
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
