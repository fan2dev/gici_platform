import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tariff_cubit.dart';

class TariffFormPage extends StatefulWidget {
  const TariffFormPage({this.tariff, super.key});

  /// When non-null we are editing, otherwise creating.
  final dynamic tariff;

  @override
  State<TariffFormPage> createState() => _TariffFormPageState();
}

class _TariffFormPageState extends State<TariffFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _scheduleCtrl;
  late final TextEditingController _priceCtrl;
  late bool _includesTransport;

  bool get _isEditing => widget.tariff != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(
      text: _isEditing ? widget.tariff.name as String? ?? '' : '',
    );
    _descriptionCtrl = TextEditingController(
      text: _isEditing ? widget.tariff.description as String? ?? '' : '',
    );
    _scheduleCtrl = TextEditingController(
      text: _isEditing ? widget.tariff.schedule as String? ?? '' : '',
    );
    _priceCtrl = TextEditingController(
      text: _isEditing
          ? (widget.tariff.price as double?)?.toStringAsFixed(2) ?? ''
          : '',
    );
    _includesTransport =
        _isEditing ? widget.tariff.includesTransport as bool? ?? false : false;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    _scheduleCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<TariffCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    bool success;
    if (_isEditing) {
      success = await cubit.update(
        tariffId: widget.tariff.id!,
        name: _nameCtrl.text.trim(),
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        schedule: _scheduleCtrl.text.trim(),
        monthlyPrice: double.parse(_priceCtrl.text.trim()),
        includesTransport: _includesTransport,
      );
    } else {
      success = await cubit.create(
        name: _nameCtrl.text.trim(),
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        schedule: _scheduleCtrl.text.trim(),
        monthlyPrice: double.parse(_priceCtrl.text.trim()),
        includesTransport: _includesTransport,
      );
    }

    if (success && navigator.canPop()) {
      navigator.pop();
      messenger.showSnackBar(SnackBar(
        content: Text(_isEditing ? 'Tarifa actualizada' : 'Tarifa creada'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TariffCubit, TariffState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: Text(
              _isEditing ? 'Editar tarifa' : 'Nueva tarifa',
              style: const TextStyle(fontWeight: FontWeight.w700),
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
                _field(
                  controller: _nameCtrl,
                  label: 'Nombre',
                  icon: Icons.label_outline,
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
                _field(
                  controller: _scheduleCtrl,
                  label: 'Horario (ej: L-V 9:00-17:00)',
                  icon: Icons.schedule,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                _field(
                  controller: _priceCtrl,
                  label: 'Precio (\u20AC)',
                  icon: Icons.euro,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                    if (double.tryParse(v.trim()) == null) return 'Numero invalido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Incluye transporte'),
                  subtitle: const Text(
                    'Marcar si la tarifa incluye servicio de ruta',
                  ),
                  value: _includesTransport,
                  onChanged: (v) => setState(() => _includesTransport = v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.white,
                ),
                const SizedBox(height: 32),
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
                      : Text(_isEditing ? 'Guardar cambios' : 'Crear tarifa'),
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
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
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
