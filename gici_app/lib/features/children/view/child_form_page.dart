import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/section_header.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/child_repository.dart';

/// Page for creating or editing a child record.
/// Pass [child] to edit an existing record; omit it to create a new one.
class ChildFormPage extends StatefulWidget {
  const ChildFormPage({super.key, this.child});

  final Child? child;

  bool get isEditing => child != null;

  @override
  State<ChildFormPage> createState() => _ChildFormPageState();
}

class _ChildFormPageState extends State<ChildFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _medicalNotesController;
  late final TextEditingController _dietaryNotesController;
  late final TextEditingController _allergiesController;
  late final TextEditingController _emergencyContactNameController;
  late final TextEditingController _emergencyContactPhoneController;

  DateTime? _dateOfBirth;
  String _gender = 'not_specified';
  String _status = 'active';
  bool _isSaving = false;

  static const _genderOptions = [
    ('not_specified', 'Sin especificar'),
    ('male', 'Masculino'),
    ('female', 'Femenino'),
  ];

  static const _statusOptions = [
    ('active', 'Activo'),
    ('inactive', 'Inactivo'),
    ('graduated', 'Graduado'),
  ];

  @override
  void initState() {
    super.initState();
    final c = widget.child;
    _firstNameController = TextEditingController(text: c?.firstName ?? '');
    _lastNameController = TextEditingController(text: c?.lastName ?? '');
    _medicalNotesController =
        TextEditingController(text: c?.medicalNotes ?? '');
    _dietaryNotesController =
        TextEditingController(text: c?.dietaryNotes ?? '');
    _allergiesController = TextEditingController(text: c?.allergies ?? '');
    _emergencyContactNameController = TextEditingController();
    _emergencyContactPhoneController = TextEditingController();
    _dateOfBirth = c?.dateOfBirth;
    _status = c?.status ?? 'active';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _medicalNotesController.dispose();
    _dietaryNotesController.dispose();
    _allergiesController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? now.subtract(const Duration(days: 365 * 3)),
      firstDate: DateTime(now.year - 10),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona la fecha de nacimiento')),
      );
      return;
    }

    setState(() => _isSaving = true);
    final repo = sl<ChildRepository>();

    try {
      if (widget.isEditing) {
        await repo.updateChild(
          childId: widget.child!.id!,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          dateOfBirth: _dateOfBirth,
          status: _status,
          medicalNotes: _medicalNotesController.text.trim().isEmpty
              ? null
              : _medicalNotesController.text.trim(),
          dietaryNotes: _dietaryNotesController.text.trim().isEmpty
              ? null
              : _dietaryNotesController.text.trim(),
          allergies: _allergiesController.text.trim().isEmpty
              ? null
              : _allergiesController.text.trim(),
        );
      } else {
        await repo.createChild(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          dateOfBirth: _dateOfBirth!,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEditing ? 'Actualizado' : 'Creado'),
        ),
      );
      context.pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    IconData? icon,
    bool alignHint = false,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, size: 20) : null,
      alignLabelWithHint: alignHint,
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
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated) {
      return const Scaffold(body: Center(child: Text('Sin autorizar')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Editar alumno' : 'Nuevo alumno',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        surfaceTintColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // -- Basic data section --
            const SectionHeader(title: 'Datos basicos', icon: '\u{1F464}'),
            GiciCard(
              accentColor: const Color(0xFF5C6BC0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: _inputDecoration(
                      label: 'Nombre *',
                      icon: Icons.person_outline,
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Campo obligatorio'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: _inputDecoration(
                      label: 'Apellidos *',
                      icon: Icons.person_outline,
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Campo obligatorio'
                        : null,
                  ),
                  const SizedBox(height: 14),

                  // Date of birth tile
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cake_outlined,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fecha de nacimiento *',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _dateOfBirth != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(_dateOfBirth!)
                                      : 'Seleccionar fecha',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: _dateOfBirth != null
                                        ? Colors.black87
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Gender: SegmentedButton
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<String>(
                      segments: _genderOptions
                          .map(
                            (e) => ButtonSegment(
                              value: e.$1,
                              label: Text(e.$2, style: const TextStyle(fontSize: 12)),
                            ),
                          )
                          .toList(),
                      selected: {_gender},
                      onSelectionChanged: (v) =>
                          setState(() => _gender = v.first),
                      style: SegmentedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  // Status (only when editing)
                  if (widget.isEditing) ...[
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: _status,
                      decoration: _inputDecoration(
                        label: 'Estado',
                        icon: Icons.toggle_on_outlined,
                      ),
                      items: _statusOptions
                          .map((e) => DropdownMenuItem(
                              value: e.$1, child: Text(e.$2)))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _status = v ?? _status),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 8),

            // -- Medical section --
            const SectionHeader(
              title: 'Informacion medica',
              icon: '\u{1FA7A}',
            ),
            GiciCard(
              accentColor: const Color(0xFFEF5350),
              child: Column(
                children: [
                  TextFormField(
                    controller: _medicalNotesController,
                    decoration: _inputDecoration(
                      label: 'Notas medicas',
                      icon: Icons.medical_information_outlined,
                      alignHint: true,
                    ),
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _dietaryNotesController,
                    decoration: _inputDecoration(
                      label: 'Notas alimentarias',
                      icon: Icons.restaurant_outlined,
                      alignHint: true,
                    ),
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _allergiesController,
                    decoration: _inputDecoration(
                      label: 'Alergias',
                      icon: Icons.warning_amber_outlined,
                      alignHint: true,
                    ),
                    minLines: 2,
                    maxLines: 4,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // -- Emergency contact --
            const SectionHeader(
              title: 'Contacto emergencia',
              icon: '\u{1F6D1}',
            ),
            GiciCard(
              accentColor: const Color(0xFFFF7043),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emergencyContactNameController,
                    decoration: _inputDecoration(
                      label: 'Nombre del contacto',
                      icon: Icons.contact_phone_outlined,
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _emergencyContactPhoneController,
                    decoration: _inputDecoration(
                      label: 'Telefono',
                      icon: Icons.phone_outlined,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // -- Save button, pill shaped --
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: _isSaving ? null : _save,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                icon: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(
                    widget.isEditing ? 'Guardar cambios' : 'Crear alumno'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
