import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../children/cubit/children_list_cubit.dart';
import '../../children/data/child_repository.dart';
import '../cubit/classrooms_cubit.dart';
import '../data/classroom_repository.dart';

class ClassroomsPage extends StatelessWidget {
  const ClassroomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ClassroomsCubit(sl<ClassroomRepository>())..load(),
        ),
        BlocProvider(
          create: (_) =>
              ChildrenListCubit(sl<ChildRepository>(), sl<ClassroomRepository>())..loadChildren(),
        ),
      ],
      child: const _ClassroomsView(),
    );
  }
}

class _ClassroomsView extends StatelessWidget {
  const _ClassroomsView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Aulas',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      floatingActionButton: canManage
          ? FloatingActionButton.extended(
              onPressed: () => _showClassroomForm(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Nueva aula',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            )
          : null,
      body: BlocBuilder<ClassroomsCubit, ClassroomsState>(
        builder: (context, state) {
          if (state.status == ClassroomsStatus.loading) {
            return const LoadingState(message: 'Cargando aulas...');
          }
          if (state.status == ClassroomsStatus.error) {
            return ErrorState(
              message: state.errorMessage ?? 'Error al cargar aulas',
              onRetry: () => context.read<ClassroomsCubit>().load(),
            );
          }
          if (state.classrooms.isEmpty) {
            return EmptyState(
              icon: Icons.meeting_room_outlined,
              message: 'No hay aulas registradas',
              action: canManage
                  ? FilledButton.icon(
                      onPressed: () => _showClassroomForm(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Crear aula'),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    )
                  : null,
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<ClassroomsCubit>().load(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: state.classrooms.length,
                  itemBuilder: (context, index) {
                    final classroom = state.classrooms[index];
                    final assignments =
                        state.assignmentsFor(classroom.id!);
                    final color = _parseColor(classroom.color);

                    return _ClassroomCard(
                      classroom: classroom,
                      assignmentCount: assignments.length,
                      color: color,
                      onTap: () => _showClassroomDetail(
                        context,
                        classroom,
                        assignments,
                        canManage,
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.indigo;
    try {
      final cleaned = hex.replaceFirst('#', '');
      return Color(int.parse('FF$cleaned', radix: 16));
    } catch (_) {
      return Colors.indigo;
    }
  }

  void _showClassroomForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<ClassroomsCubit>(),
          child: const ClassroomFormPage(),
        ),
      ),
    );
  }

  void _showClassroomDetail(
    BuildContext context,
    dynamic classroom,
    List<dynamic> assignments,
    bool canManage,
  ) {
    final childrenCubit = context.read<ChildrenListCubit>();
    final classroomsCubit = context.read<ClassroomsCubit>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: classroomsCubit),
                  BlocProvider.value(value: childrenCubit),
                ],
                child: _ClassroomDetailSheet(
                  classroom: classroom,
                  scrollController: scrollController,
                  canManage: canManage,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

String _statusLabel(String status) {
  switch (status) {
    case 'active':
      return 'Activa';
    case 'inactive':
      return 'Inactiva';
    default:
      return status;
  }
}

// ---------------------------------------------------------------------------
// Classroom card
// ---------------------------------------------------------------------------
class _ClassroomCard extends StatelessWidget {
  const _ClassroomCard({
    required this.classroom,
    required this.assignmentCount,
    required this.color,
    required this.onTap,
  });

  final dynamic classroom;
  final int assignmentCount;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final capacity = classroom.capacity as int;
    final fraction = capacity > 0 ? assignmentCount / capacity : 0.0;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored top band
              Container(height: 8, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classroom.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (classroom.description != null &&
                          (classroom.description as String).isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          classroom.description!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const Spacer(),
                      // Capacity bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: fraction.clamp(0.0, 1.0),
                          backgroundColor: Colors.grey.shade100,
                          valueColor: AlwaysStoppedAnimation(color),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.people_outline_rounded,
                              size: 16, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            '$assignmentCount/$capacity',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          StatusPill(
                            label: _statusLabel(classroom.status),
                            color: classroom.status == 'active'
                                ? const Color(0xFF43A047)
                                : Colors.grey,
                            small: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom sheet detail
// ---------------------------------------------------------------------------
class _ClassroomDetailSheet extends StatelessWidget {
  const _ClassroomDetailSheet({
    required this.classroom,
    required this.scrollController,
    required this.canManage,
  });

  final dynamic classroom;
  final ScrollController scrollController;
  final bool canManage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomsCubit, ClassroomsState>(
      builder: (context, classroomsState) {
        final assignments =
            classroomsState.assignmentsFor(classroom.id!);

        return BlocBuilder<ChildrenListCubit, ChildrenListState>(
          builder: (context, childrenState) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  classroom.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Capacidad: ${classroom.capacity} | Estado: ${_statusLabel(classroom.status)}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                if (classroom.description != null &&
                    (classroom.description as String).isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    classroom.description!,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
                const SizedBox(height: 20),

                // Assigned children
                Text(
                  'Alumnos asignados (${assignments.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                if (assignments.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'No hay alumnos asignados a esta aula.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  )
                else
                  ...assignments.map(
                    (a) {
                      final child = childrenState.children
                          .where((c) => c.id == a.childId)
                          .firstOrNull;
                      final name = child != null
                          ? '${child.firstName} ${child.lastName}'
                          : 'Alumno ${a.childId}';
                      return GiciCard(
                        child: Row(
                          children: [
                            GiciAvatar(name: name, radius: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                // Assign more
                if (canManage) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Asignar alumno',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (childrenState.status == ChildrenListStatus.loading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: childrenState.children
                          .where((c) =>
                              !assignments.any((a) => a.childId == c.id))
                          .map(
                            (child) => ActionChip(
                              avatar: GiciAvatar(
                                name:
                                    '${child.firstName} ${child.lastName}',
                                radius: 12,
                              ),
                              label: Text(
                                '${child.firstName} ${child.lastName}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              onPressed: () {
                                context
                                    .read<ClassroomsCubit>()
                                    .assignChild(
                                      classroomId: classroom.id!,
                                      childId: child.id!,
                                    );
                              },
                            ),
                          )
                          .toList(),
                    ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Classroom form page
// ---------------------------------------------------------------------------
class ClassroomFormPage extends StatefulWidget {
  const ClassroomFormPage({super.key});

  @override
  State<ClassroomFormPage> createState() => _ClassroomFormPageState();
}

class _ClassroomFormPageState extends State<ClassroomFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _capacityController = TextEditingController(text: '20');
  final _ageMinController = TextEditingController();
  final _ageMaxController = TextEditingController();
  final _colorController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _capacityController.dispose();
    _ageMinController.dispose();
    _ageMaxController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    await context.read<ClassroomsCubit>().createClassroom(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          capacity: int.tryParse(_capacityController.text) ?? 20,
          ageGroupMin: int.tryParse(_ageMinController.text),
          ageGroupMax: int.tryParse(_ageMaxController.text),
          color: _colorController.text.trim().isEmpty
              ? null
              : _colorController.text.trim(),
        );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  InputDecoration _inputDec(String label, {String? hint, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, size: 20) : null,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Nueva aula',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        surfaceTintColor: Colors.transparent,
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
                  GiciCard(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: _inputDec(
                            'Nombre del aula *',
                            hint: 'Ej: Aula Mariposas',
                            icon: Icons.meeting_room_outlined,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'El nombre es obligatorio'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: _inputDec(
                            'Descripción',
                            hint: 'Descripción opcional del aula',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _capacityController,
                          decoration: _inputDec(
                            'Capacidad *',
                            hint: 'Número máximo de alumnos',
                            icon: Icons.people_outline,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'La capacidad es obligatoria';
                            }
                            final n = int.tryParse(v);
                            if (n == null || n <= 0) {
                              return 'Introduce un número válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _ageMinController,
                                decoration: _inputDec('Edad min (meses)'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _ageMaxController,
                                decoration: _inputDec('Edad max (meses)'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _colorController,
                          decoration: _inputDec(
                            'Color (hex)',
                            hint: '#FF5722',
                            icon: Icons.color_lens_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: _isSaving ? null : _submit,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Crear aula'),
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
