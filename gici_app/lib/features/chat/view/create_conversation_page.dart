import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/section_header.dart';
import '../../../core/di/injection.dart';
import '../data/chat_repository.dart';

/// Conversation type options for the create form.
enum _ConversationType {
  direct('direct', 'Directa', Icons.person_outline, 'Conversacion uno a uno'),
  group('group', 'Grupo', Icons.group_outlined, 'Chat con varios participantes'),
  childContext('child_context', 'Por alumno', Icons.child_care_outlined, 'Sobre un alumno/a');

  const _ConversationType(this.value, this.label, this.icon, this.description);
  final String value;
  final String label;
  final IconData icon;
  final String description;
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
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Nueva conversacion',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ---- Conversation type selector ----
                const SectionHeader(
                  title: 'Tipo de conversacion',
                  icon: '\u{1F4AC}',
                ),
                ..._ConversationType.values.map(
                  (type) => _TypeSelectorCard(
                    type: type,
                    isSelected: _selectedType == type,
                    onTap: () => setState(() => _selectedType = type),
                  ),
                ),

                const SizedBox(height: 20),

                // ---- Form fields ----
                const SectionHeader(
                  title: 'Detalles',
                  icon: '\u{270F}\uFE0F',
                ),
                GiciCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Participant ID
                      TextFormField(
                        controller: _participantController,
                        decoration: InputDecoration(
                          labelText: 'ID del participante (UUID)',
                          hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                          prefixIcon: const Icon(Icons.person_add_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
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

                      // Title (optional, mainly for groups)
                      if (_selectedType != _ConversationType.direct) ...[
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Titulo (opcional)',
                            prefixIcon: const Icon(Icons.title),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],

                      // Related child ID (for child-context)
                      if (_selectedType ==
                          _ConversationType.childContext) ...[
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _childIdController,
                          decoration: InputDecoration(
                            labelText: 'ID del alumno/a (UUID, opcional)',
                            prefixIcon:
                                const Icon(Icons.child_care_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value != null &&
                                value.trim().isNotEmpty) {
                              try {
                                UuidValue.fromString(value.trim());
                              } catch (_) {
                                return 'UUID no valido';
                              }
                            }
                            return null;
                          },
                        ),
                      ],

                      // Related classroom ID
                      if (_selectedType != _ConversationType.direct) ...[
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _classroomIdController,
                          decoration: InputDecoration(
                            labelText: 'ID del aula (UUID, opcional)',
                            prefixIcon:
                                const Icon(Icons.class_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value != null &&
                                value.trim().isNotEmpty) {
                              try {
                                UuidValue.fromString(value.trim());
                              } catch (_) {
                                return 'UUID no valido';
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ---- Submit ----
                SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _isSubmitting ? null : _submit,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    label: const Text(
                      'Crear conversacion',
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
    );
  }
}

class _TypeSelectorCard extends StatelessWidget {
  const _TypeSelectorCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final _ConversationType type;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected ? primary.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? primary : Colors.grey.shade100,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primary.withValues(alpha: 0.15)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    type.icon,
                    color: isSelected ? primary : Colors.grey.shade500,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type.label,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: isSelected
                              ? primary
                              : Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        type.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: primary, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
