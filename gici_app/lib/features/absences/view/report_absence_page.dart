import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid_value.dart';

import '../cubit/absence_cubit.dart';

class ReportAbsencePage extends StatefulWidget {
  const ReportAbsencePage({super.key});

  @override
  State<ReportAbsencePage> createState() => _ReportAbsencePageState();
}

class _ReportAbsencePageState extends State<ReportAbsencePage> {
  final _formKey = GlobalKey<FormState>();
  final _childIdCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _reason = 'enfermedad';
  bool _justified = false;

  static const _reasons = [
    ('enfermedad', 'Enfermedad'),
    ('vacaciones', 'Vacaciones'),
    ('personal', 'Personal'),
    ('otro', 'Otro'),
  ];

  @override
  void dispose() {
    _childIdCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final childId = _childIdCtrl.text.trim();
    UuidValue parsedChildId;
    try {
      parsedChildId = UuidValue.fromString(childId);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID de alumno invalido')),
      );
      return;
    }

    final cubit = context.read<AbsenceCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final success = await cubit.report(
      childId: parsedChildId,
      date: _selectedDate,
      reason: _reason,
      isJustified: _justified,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
    );

    if (success && navigator.canPop()) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('Ausencia registrada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        final dateStr =
            '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}';

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Registrar ausencia',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Child ID
                TextFormField(
                  controller: _childIdCtrl,
                  decoration: _decoration('ID del alumno', Icons.child_care),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),

                // Date selector
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Fecha'),
                  subtitle: Text(dateStr),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  onTap: _pickDate,
                  trailing: const Icon(Icons.edit_calendar),
                ),
                const SizedBox(height: 16),

                // Reason dropdown
                DropdownButtonFormField<String>(
                  value: _reason,
                  decoration: _decoration('Motivo', Icons.category_outlined),
                  items: _reasons
                      .map((r) => DropdownMenuItem(value: r.$1, child: Text(r.$2)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _reason = v);
                  },
                ),
                const SizedBox(height: 16),

                // Justified toggle
                SwitchListTile(
                  title: const Text('Justificada'),
                  subtitle: const Text('Marcar si la ausencia esta justificada'),
                  value: _justified,
                  onChanged: (v) => setState(() => _justified = v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.white,
                ),
                const SizedBox(height: 16),

                // Notes
                TextFormField(
                  controller: _notesCtrl,
                  decoration: _decoration('Notas (opcional)', Icons.notes),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),

                // Submit
                FilledButton(
                  onPressed: state.isActing ? null : _submit,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: state.isActing
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Registrar ausencia'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }
}
