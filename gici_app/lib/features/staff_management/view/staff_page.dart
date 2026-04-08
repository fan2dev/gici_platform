import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/empty_state.dart';
import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_avatar.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/status_pill.dart';
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

/// Role categories for the filter pills.
enum _StaffCategory { all, management, teachers, other }

class _StaffPageContent extends StatefulWidget {
  const _StaffPageContent();

  @override
  State<_StaffPageContent> createState() => _StaffPageContentState();
}

class _StaffPageContentState extends State<_StaffPageContent> {
  _StaffCategory _category = _StaffCategory.all;

  List<AppUser> _filterStaff(List<AppUser> staff) {
    switch (_category) {
      case _StaffCategory.all:
        return staff;
      case _StaffCategory.management:
        return staff.where((u) => u.role == 'organization_admin').toList();
      case _StaffCategory.teachers:
        return staff.where((u) => u.role == 'staff').toList();
      case _StaffCategory.other:
        return staff.where((u) => u.role == 'other_staff').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffCubit, StaffState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Personal',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            leading: IconButton(
              onPressed: () => context.go('/direccion'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateDialog(context),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.person_add, color: Colors.white),
          ),
          body: _buildBody(context, state),
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

    final filtered = _filterStaff(state.staff);

    return Column(
      children: [
        // Category filter pills
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            children: [
              _PillTab(
                label: 'Todos',
                count: state.staff.length,
                isSelected: _category == _StaffCategory.all,
                onTap: () => setState(() => _category = _StaffCategory.all),
              ),
              const SizedBox(width: 8),
              _PillTab(
                label: 'Direccion',
                count: state.staff
                    .where((u) => u.role == 'organization_admin')
                    .length,
                isSelected: _category == _StaffCategory.management,
                onTap: () =>
                    setState(() => _category = _StaffCategory.management),
              ),
              const SizedBox(width: 8),
              _PillTab(
                label: 'Profesorado',
                count: state.staff.where((u) => u.role == 'staff').length,
                isSelected: _category == _StaffCategory.teachers,
                onTap: () =>
                    setState(() => _category = _StaffCategory.teachers),
              ),
              const SizedBox(width: 8),
              _PillTab(
                label: 'Otros',
                count:
                    state.staff.where((u) => u.role == 'other_staff').length,
                isSelected: _category == _StaffCategory.other,
                onTap: () => setState(() => _category = _StaffCategory.other),
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildStaffList(context, filtered),
        ),
      ],
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        itemCount: staff.length,
        itemBuilder: (context, index) {
          final user = staff[index];
          return _UserCard(
            user: user,
            onEdit: () => _showEditDialog(context, user),
          );
        },
      ),
    );
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'Nuevo miembro',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: lastNameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passCtrl,
                      decoration: InputDecoration(
                        labelText: 'Contrasena',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneCtrl,
                      decoration: InputDecoration(
                        labelText: 'Telefono (opc.)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: InputDecoration(
                        labelText: 'Rol',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'organization_admin',
                            child: Text('Direccion')),
                        DropdownMenuItem(
                            value: 'staff',
                            child: Text('Profesorado')),
                        DropdownMenuItem(
                            value: 'other_staff',
                            child: Text('Otro personal')),
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
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text(
                'Editar miembro',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: lastNameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneCtrl,
                      decoration: InputDecoration(
                        labelText: 'Telefono',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: InputDecoration(
                        labelText: 'Rol',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'organization_admin',
                            child: Text('Direccion')),
                        DropdownMenuItem(
                            value: 'staff',
                            child: Text('Profesorado')),
                        DropdownMenuItem(
                            value: 'other_staff',
                            child: Text('Otro personal')),
                      ],
                      onChanged: (v) => setState(() => selectedRole = v!),
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: const Text('Activo'),
                      value: isActive,
                      onChanged: (v) => setState(() => isActive = v),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
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

class _PillTab extends StatelessWidget {
  const _PillTab({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    required this.user,
    this.onEdit,
  });

  final AppUser user;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final rolePill = _rolePill(user.role);

    return GiciCard(
      child: Row(
        children: [
          GiciAvatar(
            name: '${user.firstName} ${user.lastName}',
            radius: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    rolePill,
                    const SizedBox(width: 6),
                    if (!user.isActive) StatusPill.inactive(),
                  ],
                ),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              icon: Icon(Icons.edit_outlined,
                  size: 18, color: Colors.grey.shade400),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }

  Widget _rolePill(String role) {
    switch (role) {
      case 'organization_admin':
        return const StatusPill(
          label: 'Direccion',
          color: Color(0xFF1E88E5),
          small: true,
        );
      case 'staff':
        return const StatusPill(
          label: 'Profesorado',
          color: Color(0xFF43A047),
          small: true,
        );
      case 'other_staff':
        return const StatusPill(
          label: 'Otro personal',
          color: Color(0xFFFF9800),
          small: true,
        );
      default:
        return StatusPill(label: role, small: true);
    }
  }
}
