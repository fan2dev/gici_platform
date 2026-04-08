import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/section_header.dart';
import '../cubit/habits_cubit.dart';

/// Form page for creating or editing a bowel movement / diaper entry.
class BowelFormPage extends StatefulWidget {
  const BowelFormPage({this.existingEntry, this.onBulkSave, super.key});

  final BowelMovementEntry? existingEntry;
  final Future<void> Function(String eventType, DateTime? eventAt, String? consistency, String? notes)? onBulkSave;

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
    ('toilet', 'WC', Icons.wc_rounded, Color(0xFF4DB6AC)),
    ('diaper', 'Panal', Icons.baby_changing_station_rounded, Color(0xFF7986CB)),
    ('accident', 'Accidente', Icons.warning_rounded, Color(0xFFFF7043)),
  ];

  static const _consistencies = [
    ('liquid', 'Liquido', Icons.water_drop_rounded, Color(0xFF42A5F5)),
    ('normal', 'Normal', Icons.check_circle_rounded, Color(0xFF66BB6A)),
    ('hard', 'Dura', Icons.circle, Color(0xFF8D6E63)),
  ];

  @override
  void initState() {
    super.initState();
    final entry = widget.existingEntry;
    _eventType = entry?.eventType ?? 'diaper';
    _eventAt = entry?.eventAt ?? DateTime.now().toUtc();
    _consistency = entry?.consistency;
    _notesController = TextEditingController(text: entry?.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_eventAt.toLocal()),
    );
    if (time == null || !mounted) return;

    final now = DateTime.now();
    setState(() {
      _eventAt = DateTime.utc(
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

    if (widget.onBulkSave != null) {
      await widget.onBulkSave!(_eventType, _eventAt, _consistency, notes);
      return;
    }

    final cubit = context.read<HabitsCubit>();
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
    final primary = Theme.of(context).colorScheme.primary;
    final localTime = _eventAt.toLocal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Deposicion' : 'Nueva Deposicion',
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
                  // Event type: 3 large quick-tap buttons
                  const SectionHeader(title: 'Lugar'),
                  Row(
                    children: _eventTypes.map((t) {
                      final selected = _eventType == t.$1;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: t != _eventTypes.last ? 10 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _eventType = t.$1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18),
                              decoration: BoxDecoration(
                                color: selected
                                    ? t.$4.withValues(alpha: 0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: selected
                                      ? t.$4
                                      : Colors.grey.shade200,
                                  width: selected ? 2.5 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    t.$3,
                                    size: 28,
                                    color: selected
                                        ? t.$4
                                        : Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    t.$2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: selected
                                          ? t.$4
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

                  // Consistency: 3 large quick-tap buttons (NOT dropdown)
                  const SectionHeader(title: 'Consistencia'),
                  Row(
                    children: _consistencies.map((c) {
                      final selected = _consistency == c.$1;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: c != _consistencies.last ? 10 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _consistency = c.$1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18),
                              decoration: BoxDecoration(
                                color: selected
                                    ? c.$4.withValues(alpha: 0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: selected
                                      ? c.$4
                                      : Colors.grey.shade200,
                                  width: selected ? 2.5 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    c.$3,
                                    size: 28,
                                    color: selected
                                        ? c.$4
                                        : Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c.$2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: selected
                                          ? c.$4
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

                  // Time picker tile — defaults to NOW
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
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
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

                  // Notes
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'Notas (opcional)',
                      hintText: 'Observaciones...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Colors.grey.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: primary, width: 1.5),
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
