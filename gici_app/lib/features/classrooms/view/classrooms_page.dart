import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../children/data/child_repository.dart';
import '../data/classroom_repository.dart';

class ClassroomsPage extends StatefulWidget {
  const ClassroomsPage({super.key});

  @override
  State<ClassroomsPage> createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {
  final _nameController = TextEditingController();
  final _capacityController = TextEditingController(text: '20');

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final classroomRepo = sl<ClassroomRepository>();
    final childRepo = sl<ChildRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManage = auth.isStaffOrAbove;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classrooms'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<Classroom>>(
        future: classroomRepo.listClassrooms(
          page: 0,
          pageSize: 100,
        ),
        builder: (context, classroomSnapshot) {
          if (classroomSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (classroomSnapshot.hasError) {
            return Center(child: Text('Error: ${classroomSnapshot.error}'));
          }

          final classrooms = classroomSnapshot.data ?? const <Classroom>[];

          return FutureBuilder<List<Child>>(
            future: childRepo.listChildren(
              page: 0,
              pageSize: 200,
            ),
            builder: (context, childSnapshot) {
              final children = childSnapshot.data ?? const <Child>[];

              return Column(
                children: [
                  if (canManage)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Classroom name',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _capacityController,
                              decoration: const InputDecoration(
                                labelText: 'Capacity',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            onPressed: () async {
                              final capacity =
                                  int.tryParse(_capacityController.text) ?? 20;
                              await classroomRepo.createClassroom(
                                name: _nameController.text.trim(),
                                capacity: capacity,
                              );
                              if (mounted) {
                                _nameController.clear();
                                setState(() {});
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: classrooms.length,
                      itemBuilder: (context, index) {
                        final classroom = classrooms[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  classroom.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  'Capacity: ${classroom.capacity} • Status: ${classroom.status}',
                                ),
                                if (canManage && children.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    children: children.take(3).map((child) {
                                      return OutlinedButton(
                                        onPressed: () async {
                                          await classroomRepo
                                              .assignChildToClassroom(
                                                classroomId: classroom.id!,
                                                childId: child.id!,
                                              );
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Assigned ${child.firstName} to ${classroom.name}',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Assign ${child.firstName}',
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
