import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../../app/widgets/adaptive_page.dart';
import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../core/di/injection.dart';
import '../cubit/staff_cubit.dart';
import '../data/staff_repository.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StaffCubit(sl<StaffRepository>())..load(),
      child: const _StaffPageContent(),
    );
  }
}

class _StaffPageContent extends StatelessWidget {
  const _StaffPageContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffCubit, StaffState>(
      builder: (context, state) {
        return AdaptivePage(
          title: 'Personal',
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showCreateDialog(context),
            icon: const Icon(Icons.person_add),
            label: const Text('Nuevo'),
          ),
          child: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, StaffState state) {
    if (state.status == StaffStatus.loading) {
      return const LoadingState(message: 'Cargando personal...');
    }
    if (state.status == StaffStatus.error) {
      return ErrorState(
        message: state.errorMessage ?? 'Error al cargar',
        onRetry: () => context.read<StaffCubit>().load(),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Personal'),
              Tab(text: 'Familias'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildStaffList(context, state.staff),
                _buildGuardianList(state.guardians),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList(BuildContext context, List<AppUser> staff) {
    if (staff.isEmpty) {
      return const EmptyState(
        message: 'No hay personal registrado',
        icon: Icons.people_outline,
      );
    }
    return RefreshIndicator(
      onRefresh: () => context.read<StaffCubit>().load(),
      child: ListView.builder(
        itemCount: staff.length,
        itemBuilder: (context, index) {
          final user = staff[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.firstName[0].toUpperCase()),
              ),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text('${user.email} · ${_roleLabel(user.role)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!user.isActive)
                    const Chip(
                      label: Text('Inactivo'),
                      backgroundColor: Colors.orange,
                    ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(context, user),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuardianList(List<AppUser> guardians) {
    if (guardians.isEmpty) {
      return const EmptyState(
        message: 'No hay familias registradas',
        icon: Icons.family_restroom,
      );
    }
    return ListView.builder(
      itemCount: guardians.length,
      itemBuilder: (context, index) {
        final user = guardians[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: Text(user.firstName[0].toUpperCase()),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
          ),
        );
      },
    );
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'organization_admin':
        return 'Dirección';
      case 'staff':
        return 'Personal';
      default:
        return role;
    }
  }

  void _showCreateDialog(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final firstNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    String selectedRole = 'staff';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Nuevo miembro'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameCtrl,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: lastNameCtrl,
                      decoration: const InputDecoration(labelText: 'Apellidos'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phoneCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Teléfono (opc.)'),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(labelText: 'Rol'),
                      items: const [
                        DropdownMenuItem(
                            value: 'staff', child: Text('Personal')),
                        DropdownMenuItem(
                            value: 'organization_admin',
                            child: Text('Dirección')),
                      ],
                      onChanged: (v) => setState(() => selectedRole = v!),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () {
                    context.read<StaffCubit>().createUser(
                          email: emailCtrl.text.trim(),
                          password: passCtrl.text,
                          firstName: firstNameCtrl.text.trim(),
                          lastName: lastNameCtrl.text.trim(),
                          role: selectedRole,
                          phone: phoneCtrl.text.trim().isEmpty
                              ? null
                              : phoneCtrl.text.trim(),
                        );
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Crear'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, AppUser user) {
    final firstNameCtrl = TextEditingController(text: user.firstName);
    final lastNameCtrl = TextEditingController(text: user.lastName);
    final phoneCtrl = TextEditingController(text: user.phone ?? '');
    String selectedRole = user.role;
    bool isActive = user.isActive;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Editar miembro'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameCtrl,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: lastNameCtrl,
                      decoration: const InputDecoration(labelText: 'Apellidos'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phoneCtrl,
                      decoration: const InputDecoration(labelText: 'Teléfono'),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(labelText: 'Rol'),
                      items: const [
                        DropdownMenuItem(
                            value: 'staff', child: Text('Personal')),
                        DropdownMenuItem(
                            value: 'organization_admin',
                            child: Text('Dirección')),
                      ],
                      onChanged: (v) => setState(() => selectedRole = v!),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Activo'),
                      value: isActive,
                      onChanged: (v) => setState(() => isActive = v),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () {
                    context.read<StaffCubit>().updateUser(
                          userId: user.id!,
                          firstName: firstNameCtrl.text.trim(),
                          lastName: lastNameCtrl.text.trim(),
                          phone: phoneCtrl.text.trim().isEmpty
                              ? null
                              : phoneCtrl.text.trim(),
                          role: selectedRole,
                          isActive: isActive,
                        );
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
