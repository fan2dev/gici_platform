import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/adaptive_page.dart';
import '../../../core/di/injection.dart';
import '../data/chat_repository.dart';

/// Conversation type options for the create form.
enum _ConversationType {
  direct('direct', 'Directa', Icons.person_outline),
  group('group', 'Grupo', Icons.group_outlined),
  childContext('child_context', 'Contexto alumno/a', Icons.child_care_outlined);

  const _ConversationType(this.value, this.label, this.icon);
  final String value;
  final String label;
  final IconData icon;
}

class CreateConversationPage extends StatefulWidget {
  const CreateConversationPage({super.key});

  @override
  State<CreateConversationPage> createState() => _CreateConversationPageState();
}

class _CreateConversationPageState extends State<CreateConversationPage> {
  final _formKey = GlobalKey<FormState>();
  final _participantController = TextEditingController();
  final _titleController = TextEditingController();
  final _childIdController = TextEditingController();
  final _classroomIdController = TextEditingController();

  _ConversationType _selectedType = _ConversationType.direct;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _participantController.dispose();
    _titleController.dispose();
    _childIdController.dispose();
    _classroomIdController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final repo = sl<ChatRepository>();
      final participantId =
          UuidValue.fromString(_participantController.text.trim());

      final title = _titleController.text.trim().isEmpty
          ? null
          : _titleController.text.trim();

      UuidValue? relatedChildId;
      if (_selectedType == _ConversationType.childContext &&
          _childIdController.text.trim().isNotEmpty) {
        relatedChildId =
            UuidValue.fromString(_childIdController.text.trim());
      }

      UuidValue? relatedClassroomId;
      if (_classroomIdController.text.trim().isNotEmpty) {
        relatedClassroomId =
            UuidValue.fromString(_classroomIdController.text.trim());
      }

      final conversation = await repo.createConversation(
        conversationType: _selectedType.value,
        title: title,
        relatedChildId: relatedChildId,
        relatedClassroomId: relatedClassroomId,
        participantUserIds: [participantId],
      );

      if (!mounted) return;
      context.go('/chat/${conversation.id}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear conversacion: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AdaptivePage(
      title: 'Nueva conversacion',
      maxWidth: 600,
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // ---- Conversation type selector ----
            Text('Tipo de conversacion',
                style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<_ConversationType>(
              segments: _ConversationType.values
                  .map((t) => ButtonSegment(
                        value: t,
                        label: Text(t.label),
                        icon: Icon(t.icon),
                      ))
                  .toList(),
              selected: {_selectedType},
              onSelectionChanged: (selected) {
                setState(() => _selectedType = selected.first);
              },
            ),
            const SizedBox(height: 24),

            // ---- Participant ID ----
            TextFormField(
              controller: _participantController,
              decoration: const InputDecoration(
                labelText: 'ID del participante (UUID)',
                hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                prefixIcon: Icon(Icons.person_add_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Introduce el ID del participante';
                }
                try {
                  UuidValue.fromString(value.trim());
                } catch (_) {
                  return 'UUID no valido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // ---- Title (optional, mainly for groups) ----
            if (_selectedType != _ConversationType.direct) ...[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titulo (opcional)',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ---- Related child ID (for child-context) ----
            if (_selectedType == _ConversationType.childContext) ...[
              TextFormField(
                controller: _childIdController,
                decoration: const InputDecoration(
                  labelText: 'ID del alumno/a (UUID, opcional)',
                  prefixIcon: Icon(Icons.child_care_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    try {
                      UuidValue.fromString(value.trim());
                    } catch (_) {
                      return 'UUID no valido';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
            ],

            // ---- Related classroom ID (optional for group / child-context) ----
            if (_selectedType != _ConversationType.direct) ...[
              TextFormField(
                controller: _classroomIdController,
                decoration: const InputDecoration(
                  labelText: 'ID del aula (UUID, opcional)',
                  prefixIcon: Icon(Icons.class_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    try {
                      UuidValue.fromString(value.trim());
                    } catch (_) {
                      return 'UUID no valido';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
            ],

            const SizedBox(height: 16),

            // ---- Submit ----
            FilledButton.icon(
              onPressed: _isSubmitting ? null : _submit,
              icon: _isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: const Text('Crear conversacion'),
            ),
          ],
        ),
      ),
    );
  }
}
