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
              role: authState.role,
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
// Wide layout: custom sidebar + main content (unchanged)
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
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            width: isExtended ? 260 : 78,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.7)],
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(Icons.child_care_rounded, color: Colors.white, size: 22),
                      ),
                      if (isExtended) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('GICI',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800, color: colorScheme.primary, letterSpacing: 1.2),
                            overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.all(isExtended ? 12 : 10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: isExtended ? MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [
                        GiciAvatar(name: authState.displayName, radius: isExtended ? 19 : 17, color: colorScheme.primary),
                        if (isExtended) ...[
                          const SizedBox(width: 10),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(authState.displayName,
                                style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              StatusPill(label: _roleLabel(authState.role), color: colorScheme.primary, small: true),
                            ],
                          )),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1, color: Colors.grey.shade100)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = index == selectedIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Material(
                            color: Colors.transparent, borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () => context.go(item.path),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: isExtended ? 14 : 0, vertical: 11),
                                child: Row(
                                  mainAxisAlignment: isExtended ? MainAxisAlignment.start : MainAxisAlignment.center,
                                  children: [
                                    Icon(isSelected ? item.activeIcon : item.icon, size: 22,
                                      color: isSelected ? colorScheme.primary : Colors.grey.shade500),
                                    if (isExtended) ...[
                                      const SizedBox(width: 14),
                                      Expanded(child: Text(item.label,
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                          color: isSelected ? colorScheme.primary : Colors.grey.shade700),
                                        overflow: TextOverflow.ellipsis)),
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
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1, color: Colors.grey.shade100)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
                  child: Tooltip(
                    message: 'Cerrar sesión',
                    child: Material(
                      color: Colors.transparent, borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => context.read<AuthCubit>().signOut(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: isExtended ? 14 : 0, vertical: 11),
                          child: Row(
                            mainAxisAlignment: isExtended ? MainAxisAlignment.start : MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded, size: 22, color: colorScheme.error.withValues(alpha: 0.7)),
                              if (isExtended) ...[
                                const SizedBox(width: 14),
                                Text('Cerrar sesión', style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.error.withValues(alpha: 0.7), fontWeight: FontWeight.w500)),
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
          Expanded(child: child),
        ],
      ),
    );
  }

  String _roleLabel(AppRole? role) {
    switch (role) {
      case AppRole.platformSuperAdmin: return 'Super Admin';
      case AppRole.organizationAdmin: return 'Dirección';
      case AppRole.staff: return 'Personal';
      case AppRole.otherStaff: return 'Colaborador';
      case AppRole.guardian: return 'Familia';
      case null: return '';
    }
  }
}

// ---------------------------------------------------------------------------
// Narrow layout: animated bottom nav with docked active circle
// ---------------------------------------------------------------------------

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.items,
    required this.selectedIndex,
    required this.role,
    required this.child,
  });

  final List<NavItem> items;
  final int selectedIndex;
  final AppRole? role;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Fixed bottom bar items per role — NO "Más" overflow
    final bottomItems = getPrimaryNavItems(role);
    final currentPath = GoRouterState.of(context).uri.path;

    int activeIndex = -1;
    for (var i = 0; i < bottomItems.length; i++) {
      if (currentPath.startsWith(bottomItems[i].path)) {
        activeIndex = i;
        break;
      }
    }

    const double barHeight = 52;
    const double dockedSize = 38;
    const double dockedOverhang = 8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: child),

          // Bottom bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200, width: 0.5)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 4),
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(bottomItems.length, (index) {
                    final item = bottomItems[index];
                    final isActive = index == activeIndex;

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => context.go(item.path),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              width: isActive ? dockedSize : 32,
                              height: isActive ? dockedSize : 32,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? colorScheme.primary
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isActive ? item.activeIcon : item.icon,
                                size: isActive ? 19 : 18,
                                color: isActive
                                    ? Colors.white
                                    : Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: isActive
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isActive
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
