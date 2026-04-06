import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/widgets/gici_card.dart';
import '../cubit/notifications_cubit.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String _targetScope = 'organization';
  String _category = 'general';
  bool _isSending = false;

  static const _categories = [
    ('general', 'General'),
    ('alert', 'Alerta'),
    ('message', 'Mensaje'),
    ('event', 'Evento'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    await context.read<NotificationsCubit>().sendNotification(
          title: _titleController.text.trim(),
          body: _bodyController.text.trim(),
          category: _category,
          targetScope: _targetScope,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notificacion enviada')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Enviar notificacion',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Form card
                  GiciCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detalles',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Titulo',
                            hintText: 'Titulo de la notificacion',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'El titulo es obligatorio'
                              : null,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _bodyController,
                          decoration: InputDecoration(
                            labelText: 'Mensaje',
                            hintText: 'Contenido de la notificacion',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 4,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'El mensaje es obligatorio'
                              : null,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _category,
                          decoration: InputDecoration(
                            labelText: 'Categoria',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          items: _categories
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c.$1,
                                  child: Text(c.$2),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => _category = v);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Scope selector
                  GiciCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Destinatarios',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<String>(
                            segments: const [
                              ButtonSegment(
                                value: 'organization',
                                label: Text('Todos'),
                                icon: Icon(Icons.groups_outlined, size: 18),
                              ),
                              ButtonSegment(
                                value: 'classroom',
                                label: Text('Aula'),
                                icon: Icon(Icons.class_outlined, size: 18),
                              ),
                              ButtonSegment(
                                value: 'child',
                                label: Text('Alumno'),
                                icon: Icon(Icons.person_outline, size: 18),
                              ),
                            ],
                            selected: {_targetScope},
                            onSelectionChanged: (selected) {
                              setState(
                                  () => _targetScope = selected.first);
                            },
                          ),
                        ),
                        if (_targetScope == 'classroom') ...[
                          const SizedBox(height: 12),
                          Text(
                            'Se enviara a todos los miembros del aula seleccionada.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                        if (_targetScope == 'child') ...[
                          const SizedBox(height: 12),
                          Text(
                            'Se enviara a los tutores del alumno seleccionado.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Preview
                  if (_titleController.text.trim().isNotEmpty ||
                      _bodyController.text.trim().isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Vista previa',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    GiciCard(
                      accentColor: primary,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.notifications_active_outlined,
                              color: primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _titleController.text.trim().isEmpty
                                      ? 'Titulo'
                                      : _titleController.text.trim(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                if (_bodyController.text
                                    .trim()
                                    .isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    _bodyController.text.trim(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Text(
                            'Ahora',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 8),

                  // Send button
                  SizedBox(
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: _isSending ? null : _send,
                      icon: _isSending
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send),
                      label: const Text(
                        'Enviar notificacion',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
