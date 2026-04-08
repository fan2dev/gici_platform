import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/calendar_cubit.dart';

class CalendarEventFormPage extends StatefulWidget {
  const CalendarEventFormPage({this.event, super.key});

  /// When non-null we are editing, otherwise creating.
  final dynamic event;

  @override
  State<CalendarEventFormPage> createState() => _CalendarEventFormPageState();
}

class _CalendarEventFormPageState extends State<CalendarEventFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descriptionCtrl;
  late DateTime _date;
  late DateTime? _endDate;
  late String _eventType;
  late bool _recurring;

  bool get _isEditing => widget.event != null;

  static const _eventTypes = [
    ('festivo', 'Festivo'),
    ('reunion', 'Reunion'),
    ('excursion', 'Excursion'),
    ('celebracion', 'Celebracion'),
    ('cierre', 'Cierre'),
  ];

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(
      text: _isEditing ? widget.event.title as String? ?? '' : '',
    );
    _descriptionCtrl = TextEditingController(
      text: _isEditing ? widget.event.description as String? ?? '' : '',
    );
    _date = _isEditing
        ? (widget.event.eventDate as DateTime?) ?? DateTime.now()
        : DateTime.now();
    _endDate = _isEditing ? widget.event.endDate as DateTime? : null;
    _eventType =
        _isEditing ? widget.event.eventType as String? ?? 'festivo' : 'festivo';
    _recurring = _isEditing ? widget.event.isRecurring as bool? ?? false : false;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate({bool isEnd = false}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isEnd ? (_endDate ?? _date) : _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isEnd) {
          _endDate = picked;
        } else {
          _date = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<CalendarCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    bool success;
    if (_isEditing) {
      success = await cubit.update(
        eventId: widget.event.id!,
        title: _titleCtrl.text.trim(),
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        eventDate: _date,
        endDate: _endDate,
        eventType: _eventType,
        isRecurring: _recurring,
      );
    } else {
      success = await cubit.create(
        title: _titleCtrl.text.trim(),
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        eventDate: _date,
        endDate: _endDate,
        eventType: _eventType,
        isRecurring: _recurring,
      );
    }

    if (success && navigator.canPop()) {
      navigator.pop();
      messenger.showSnackBar(SnackBar(
        content: Text(_isEditing ? 'Evento actualizado' : 'Evento creado'),
      ));
    }
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: Text(
              _isEditing ? 'Editar evento' : 'Nuevo evento',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            actions: [
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: 'Eliminar',
                  onPressed: () async {
                    final cubit = context.read<CalendarCubit>();
                    final nav = Navigator.of(context);
                    final ok = await cubit.delete(widget.event.id!);
                    if (ok && nav.canPop()) nav.pop();
                  },
                ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _field(
                  controller: _titleCtrl,
                  label: 'Titulo',
                  icon: Icons.title,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                _field(
                  controller: _descriptionCtrl,
                  label: 'Descripcion',
                  icon: Icons.description_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Date
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Fecha'),
                  subtitle: Text(_formatDate(_date)),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  onTap: () => _pickDate(),
                  trailing: const Icon(Icons.edit_calendar),
                ),
                const SizedBox(height: 16),

                // End date
                ListTile(
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: const Text('Fecha fin (opcional)'),
                  subtitle: Text(
                    _endDate != null ? _formatDate(_endDate!) : 'Sin fecha fin',
                  ),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  onTap: () => _pickDate(isEnd: true),
                  trailing: _endDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => _endDate = null),
                        )
                      : const Icon(Icons.edit_calendar),
                ),
                const SizedBox(height: 16),

                // Event type
                DropdownButtonFormField<String>(
                  value: _eventType,
                  decoration: InputDecoration(
                    labelText: 'Tipo de evento',
                    prefixIcon: const Icon(Icons.category_outlined),
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
                  ),
                  items: _eventTypes
                      .map((t) =>
                          DropdownMenuItem(value: t.$1, child: Text(t.$2)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _eventType = v);
                  },
                ),
                const SizedBox(height: 16),

                // Recurring toggle
                SwitchListTile(
                  title: const Text('Evento recurrente'),
                  subtitle:
                      const Text('Marcar si el evento se repite anualmente'),
                  value: _recurring,
                  onChanged: (v) => setState(() => _recurring = v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.white,
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
                      : Text(_isEditing ? 'Guardar cambios' : 'Crear evento'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
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
      ),
    );
  }
}
