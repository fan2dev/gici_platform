import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/child_repository.dart';

class ChildDetailPage extends StatefulWidget {
  const ChildDetailPage({super.key, required this.childId});

  final UuidValue childId;

  @override
  State<ChildDetailPage> createState() => _ChildDetailPageState();
}

class _ChildDetailPageState extends State<ChildDetailPage> {
  final _medicalController = TextEditingController();

  @override
  void dispose() {
    _medicalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<ChildRepository>();

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Detail'),
        leading: IconButton(
          onPressed: () => context.go('/children'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<ChildProfileOverview>(
        future: repo.getChildProfileOverview(
          childId: widget.childId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Error: ${snapshot.error ?? 'Not found'}'),
            );
          }

          final overview = snapshot.data!;
          final child = overview.child;
          _medicalController.text = child.medicalNotes ?? '';

          final canManage = auth.isStaffOrAbove;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${child.firstName} ${child.lastName}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text('Date of birth: ${child.dateOfBirth.toIso8601String()}'),
                Text('Status: ${child.status}'),
                const SizedBox(height: 6),
                Text('Classroom: ${overview.activeClassroomName ?? '-'}'),
                Text(
                  'Guardians: ${overview.guardianDisplayNames.isEmpty ? '-' : overview.guardianDisplayNames.join(', ')}',
                ),
                Text(
                  'Documents: ${overview.documentsCount} • Reports: ${overview.reportsCount}',
                ),
                Text(
                  'Last habit event: ${overview.lastHabitAt?.toIso8601String() ?? '-'}',
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => context.go('/timeline/${child.id}'),
                      child: const Text('Timeline'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go('/reports/${child.id}'),
                      child: const Text('Reports'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go('/habits'),
                      child: const Text('Habits'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go('/documents'),
                      child: const Text('Documents'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (canManage) ...[
                  TextField(
                    controller: _medicalController,
                    decoration: const InputDecoration(
                      labelText: 'Medical notes',
                    ),
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () async {
                      await repo.updateChild(
                        childId: child.id!,
                        medicalNotes: _medicalController.text.trim().isEmpty
                            ? null
                            : _medicalController.text.trim(),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Child updated')),
                      );
                      setState(() {});
                    },
                    child: const Text('Save'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
