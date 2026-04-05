import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../data/child_repository.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _createChild(BuildContext context) async {
    final auth = context.read<AuthCubit>().state;
    final repo = sl<ChildRepository>();

    if (auth.organizationId == null || auth.actorId == null) {
      return;
    }

    await repo.createChild(
      organizationId: auth.organizationId!,
      actorId: auth.actorId!,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      dateOfBirth: DateTime.utc(2023, 1, 1),
    );

    if (mounted) {
      _firstNameController.clear();
      _lastNameController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final repo = sl<ChildRepository>();

    if (!auth.isAuthenticated ||
        auth.organizationId == null ||
        auth.actorId == null) {
      return const Scaffold(body: Center(child: Text('Unauthorized')));
    }

    final canManage =
        auth.role == AppRole.organizationAdmin ||
        auth.role == AppRole.staff ||
        auth.role == AppRole.platformSuperAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Children'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<Child>>(
        future: repo.listChildren(
          organizationId: auth.organizationId!,
          actorId: auth.actorId!,
          page: 0,
          pageSize: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final children = snapshot.data ?? const <Child>[];
          return Column(
            children: [
              if (canManage)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () => _createChild(context),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    final child = children[index];
                    return ListTile(
                      title: Text('${child.firstName} ${child.lastName}'),
                      subtitle: Text('Status: ${child.status}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go('/children/${child.id}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
