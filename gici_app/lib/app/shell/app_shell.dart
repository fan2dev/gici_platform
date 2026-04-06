import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../widgets/gici_avatar.dart';
import '../widgets/status_pill.dart';
import 'navigation_items.dart';

/// Adaptive shell: sidebar on wide screens, bottom nav on mobile.
class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final items = getNavItemsForRole(authState.role);
        final currentPath = GoRouterState.of(context).uri.path;
        final selectedIndex = _findSelectedIndex(items, currentPath);

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= _wideBreakpoint) {
              return _WideLayout(
                items: items,
                selectedIndex: selectedIndex,
                authState: authState,
                child: child,
              );
            }
            return _NarrowLayout(
              items: items,
              selectedIndex: selectedIndex,
              child: child,
            );
          },
        );
      },
    );
  }

  int _findSelectedIndex(List<NavItem> items, String currentPath) {
    for (var i = 0; i < items.length; i++) {
      if (currentPath.startsWith(items[i].path)) return i;
    }
    return 0;
  }
}

// ---------------------------------------------------------------------------
// Wide layout: custom sidebar + main content
// ---------------------------------------------------------------------------

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.items,
    required this.selectedIndex,
    required this.authState,
    required this.child,
  });

  final List<NavItem> items;
  final int selectedIndex;
  final AuthState authState;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExtended = MediaQuery.of(context).size.width > 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Row(
        children: [
          // -- Sidebar ---------------------------------------------------
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            width: isExtended ? 260 : 78,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey.shade100),
              ),
            ),
            child: Column(
              children: [
                // -- Brand logo area ------------------------------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.primary,
                              colorScheme.primary.withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.child_care_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      if (isExtended) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'GICI',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.primary,
                              letterSpacing: 1.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // -- User card ------------------------------------------
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.all(isExtended ? 12 : 10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: isExtended
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        GiciAvatar(
                          name: authState.displayName,
                          radius: isExtended ? 19 : 17,
                          color: colorScheme.primary,
                        ),
                        if (isExtended) ...[
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authState.displayName,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                StatusPill(
                                  label: _roleLabel(authState.role),
                                  color: colorScheme.primary,
                                  small: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    color: Colors.grey.shade100,
                  ),
                ),
                const SizedBox(height: 8),

                // -- Nav items ------------------------------------------
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = index == selectedIndex;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorScheme.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () => context.go(item.path),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isExtended ? 14 : 0,
                                  vertical: 11,
                                ),
                                child: Row(
                                  mainAxisAlignment: isExtended
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                                  children: [
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: Icon(
                                        isSelected
                                            ? item.activeIcon
                                            : item.icon,
                                        key: ValueKey(isSelected),
                                        size: 22,
                                        color: isSelected
                                            ? colorScheme.primary
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                    if (isExtended) ...[
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          item.label,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                            color: isSelected
                                                ? colorScheme.primary
                                                : Colors.grey.shade700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // -- Bottom logout --------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    color: Colors.grey.shade100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
                  child: Tooltip(
                    message: 'Cerrar sesion',
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => context.read<AuthCubit>().signOut(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isExtended ? 14 : 0,
                            vertical: 11,
                          ),
                          child: Row(
                            mainAxisAlignment: isExtended
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                size: 22,
                                color: colorScheme.error.withValues(alpha: 0.7),
                              ),
                              if (isExtended) ...[
                                const SizedBox(width: 14),
                                Text(
                                  'Cerrar sesion',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.error
                                        .withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -- Main content area ----------------------------------------
          Expanded(child: child),
        ],
      ),
    );
  }

  String _roleLabel(AppRole? role) {
    switch (role) {
      case AppRole.platformSuperAdmin:
        return 'Super Admin';
      case AppRole.organizationAdmin:
        return 'Direccion';
      case AppRole.staff:
        return 'Personal';
      case AppRole.guardian:
        return 'Familia';
      case null:
        return '';
    }
  }
}

// ---------------------------------------------------------------------------
// Narrow layout: bottom navigation bar
// ---------------------------------------------------------------------------

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.items,
    required this.selectedIndex,
    required this.child,
  });

  final List<NavItem> items;
  final int selectedIndex;
  final Widget child;

  static const int _maxVisibleItems = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final showMore = items.length > _maxVisibleItems + 1;
    final bottomItems =
        showMore ? items.take(_maxVisibleItems).toList() : items;
    final overflowItems =
        showMore ? items.skip(_maxVisibleItems).toList() : <NavItem>[];

    // If current selection is in overflow, highlight "Mas"
    final effectiveIndex = selectedIndex < bottomItems.length
        ? selectedIndex
        : (showMore ? bottomItems.length : 0);

    final totalDestinations = bottomItems.length + (showMore ? 1 : 0);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...List.generate(totalDestinations, (index) {
                  final bool isMore = showMore && index == bottomItems.length;
                  final NavItem? item =
                      isMore ? null : bottomItems[index];
                  final bool isSelected = index == effectiveIndex;

                  final IconData icon = isMore
                      ? Icons.more_horiz_rounded
                      : (isSelected ? item!.activeIcon : item!.icon);
                  final String label = isMore ? 'Mas' : item!.label;

                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (isMore) {
                          _showMoreSheet(context, overflowItems);
                        } else {
                          context.go(item!.path);
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorScheme.primary.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              icon,
                              size: 22,
                              color: isSelected
                                  ? colorScheme.primary
                                  : Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? colorScheme.primary
                                  : Colors.grey.shade500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreSheet(BuildContext context, List<NavItem> items) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Mas opciones',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...items.map((item) {
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: colorScheme.primary, size: 20),
                  ),
                  title: Text(
                    item.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(item.path);
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
