import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import 'navigation_items.dart';

/// Adaptive shell that shows a sidebar on wide screens (web/tablet)
/// and a bottom navigation bar on narrow screens (mobile).
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

/// Wide layout: persistent sidebar + main content.
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: MediaQuery.of(context).size.width > 1100,
            selectedIndex: selectedIndex.clamp(0, items.length - 1),
            onDestinationSelected: (index) {
              context.go(items[index].path);
            },
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Icon(Icons.school, size: 32, color: colorScheme.primary),
                  const SizedBox(height: 4),
                  Text(
                    authState.displayName,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: 'Cerrar sesión',
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                  ),
                ),
              ),
            ),
            destinations: items.map((item) {
              return NavigationRailDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.activeIcon),
                label: Text(item.label),
              );
            }).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Narrow layout: bottom navigation bar.
/// Shows max 5 items; rest accessible via "Más" menu.
class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.items,
    required this.selectedIndex,
    required this.child,
  });

  final List<NavItem> items;
  final int selectedIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Show first 4 items + "More" if there are more than 5
    final showMore = items.length > 5;
    final bottomItems = showMore ? items.take(4).toList() : items.take(5).toList();
    final overflowItems = showMore ? items.skip(4).toList() : <NavItem>[];

    final effectiveIndex = selectedIndex < bottomItems.length
        ? selectedIndex
        : (showMore ? bottomItems.length : 0); // "More" tab

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: effectiveIndex.clamp(0, bottomItems.length + (showMore ? 0 : -1)),
        onDestinationSelected: (index) {
          if (showMore && index == bottomItems.length) {
            _showMoreMenu(context, overflowItems);
          } else if (index < bottomItems.length) {
            context.go(bottomItems[index].path);
          }
        },
        destinations: [
          ...bottomItems.map((item) => NavigationDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.activeIcon),
                label: item.label,
              )),
          if (showMore)
            const NavigationDestination(
              icon: Icon(Icons.more_horiz),
              selectedIcon: Icon(Icons.more_horiz),
              label: 'Más',
            ),
        ],
      ),
    );
  }

  void _showMoreMenu(BuildContext context, List<NavItem> items) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: items.map((item) {
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
            onTap: () {
              Navigator.pop(context);
              context.go(item.path);
            },
          );
        }).toList(),
      ),
    );
  }
}
