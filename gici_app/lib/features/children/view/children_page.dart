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
import '../../auth/cubit/auth_cubit.dart';
import '../cubit/children_list_cubit.dart';
import '../data/child_repository.dart';
import 'child_form_page.dart';

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ChildrenListCubit(sl<ChildRepository>())..loadChildren(),
      child: const _ChildrenView(),
    );
  }
}

class _ChildrenView extends StatefulWidget {
  const _ChildrenView();

  @override
  State<_ChildrenView> createState() => _ChildrenViewState();
}

class _ChildrenViewState extends State<_ChildrenView> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Child> _filtered(List<Child> children) {
    if (_searchQuery.isEmpty) return children;
    final q = _searchQuery.toLowerCase();
    return children.where((c) {
      final full = '${c.firstName} ${c.lastName}'.toLowerCase();
      return full.contains(q);
    }).toList();
  }

  Future<void> _openCreateForm(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const ChildFormPage()),
    );
    if (result == true && context.mounted) {
      context.read<ChildrenListCubit>().refresh();
    }
  }

  String _ageFromDob(DateTime dob) {
    final now = DateTime.now();
    int years = now.year - dob.year;
    int months = now.month - dob.month;
    if (now.day < dob.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    if (years > 0) {
      return '${years}a ${months}m';
    }
    return '$months mes${months == 1 ? '' : 'es'}';
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'active':
        return 'Activo';
      case 'inactive':
        return 'Inactivo';
      case 'graduated':
        return 'Graduado';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'active':
        return const Color(0xFF43A047);
      case 'inactive':
        return const Color(0xFFFB8C00);
      case 'graduated':
        return const Color(0xFF1E88E5);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;

    if (!auth.isAuthenticated || auth.organizationId == null) {
      return const Scaffold(body: Center(child: Text('Sin autorizar')));
    }

    final isAdmin = auth.isAdmin;

    return BlocBuilder<ChildrenListCubit, ChildrenListState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          floatingActionButton: isAdmin
              ? FloatingActionButton.extended(
                  onPressed: () => _openCreateForm(context),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text(
                    'Nuevo alumno',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              : null,
          body: SafeArea(
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ChildrenListState state) {
    switch (state.status) {
      case ChildrenListStatus.initial:
      case ChildrenListStatus.loading:
        return const LoadingState(message: 'Cargando alumnos...');

      case ChildrenListStatus.error:
        return ErrorState(
          message: state.errorMessage ?? 'Error desconocido',
          onRetry: () => context.read<ChildrenListCubit>().loadChildren(),
        );

      case ChildrenListStatus.loaded:
        final children = state.children;
        if (children.isEmpty) {
          return const EmptyState(
            icon: Icons.child_care_outlined,
            message: 'No hay alumnos registrados.',
          );
        }

        final filtered = _filtered(children);

        return RefreshIndicator(
          onRefresh: () => context.read<ChildrenListCubit>().refresh(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                  child: Text(
                    'Alumnos',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                  ),
                ),
              ),
              // Sticky search bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickySearchDelegate(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  query: _searchQuery,
                  onClear: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                ),
              ),
              // Count
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Text(
                    '${filtered.length} alumno${filtered.length == 1 ? '' : 's'}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              // Grid
              if (filtered.isEmpty)
                const SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.search_off,
                    message: 'Sin resultados para esta busqueda.',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount =
                          constraints.crossAxisExtent > 600 ? 2 : 1;
                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 108,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final child = filtered[index];
                            final name =
                                '${child.firstName} ${child.lastName}';
                            return GiciCard(
                              onTap: () =>
                                  context.go('/children/${child.id}'),
                              child: Row(
                                children: [
                                  GiciAvatar(name: name, radius: 28),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Text(
                                              _ageFromDob(child.dateOfBirth),
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            StatusPill(
                                              label: _statusLabel(
                                                  child.status),
                                              color: _statusColor(
                                                  child.status),
                                              small: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: filtered.length,
                        ),
                      );
                    },
                  ),
                ),
              // Bottom padding for FAB
              const SliverToBoxAdapter(
                child: SizedBox(height: 88),
              ),
            ],
          ),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Sticky search bar delegate
// ---------------------------------------------------------------------------
class _StickySearchDelegate extends SliverPersistentHeaderDelegate {
  _StickySearchDelegate({
    required this.controller,
    required this.onChanged,
    required this.query,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String query;
  final VoidCallback onClear;

  @override
  double get minExtent => 68;
  @override
  double get maxExtent => 68;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFFF5F5F7),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar alumno...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded, color: Colors.grey.shade400),
                  onPressed: onClear,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickySearchDelegate oldDelegate) =>
      query != oldDelegate.query;
}
