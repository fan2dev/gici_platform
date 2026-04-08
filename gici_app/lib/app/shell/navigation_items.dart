import 'package:flutter/material.dart';

import '../../features/auth/cubit/auth_cubit.dart';

class NavItem {
  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.path,
    this.staffOnly = false,
    this.adminOnly = false,
    this.guardianOnly = false,
    this.excludeOtherStaff = false,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String path;
  final bool staffOnly;
  final bool adminOnly;
  final bool guardianOnly;

  /// When true, users with [AppRole.otherStaff] will NOT see this item.
  final bool excludeOtherStaff;

  bool isVisibleFor(AppRole? role) {
    if (role == null) return false;
    if (adminOnly && role != AppRole.organizationAdmin && role != AppRole.platformSuperAdmin) {
      return false;
    }
    if (staffOnly && (role == AppRole.guardian)) return false;
    if (guardianOnly && role != AppRole.guardian) return false;
    if (excludeOtherStaff && role == AppRole.otherStaff) return false;
    return true;
  }
}

const allNavItems = [
  NavItem(
    label: 'Inicio',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    path: '/dashboard',
  ),
  // Time tracking right after Inicio for staff quick access
  NavItem(
    label: 'Control horario',
    icon: Icons.access_time_outlined,
    activeIcon: Icons.access_time_filled,
    path: '/time-tracking',
    staffOnly: true,
  ),
  NavItem(
    label: 'Alumnos',
    icon: Icons.child_care_outlined,
    activeIcon: Icons.child_care,
    path: '/children',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Aulas',
    icon: Icons.meeting_room_outlined,
    activeIcon: Icons.meeting_room,
    path: '/classrooms',
    staffOnly: true,
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Habitos',
    icon: Icons.restaurant_outlined,
    activeIcon: Icons.restaurant,
    path: '/habits',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Chat',
    icon: Icons.chat_outlined,
    activeIcon: Icons.chat,
    path: '/chat',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Notificaciones',
    icon: Icons.notifications_outlined,
    activeIcon: Icons.notifications,
    path: '/notifications',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Documentos',
    icon: Icons.description_outlined,
    activeIcon: Icons.description,
    path: '/documents',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Galerias',
    icon: Icons.photo_library_outlined,
    activeIcon: Icons.photo_library,
    path: '/galleries',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Ausencias',
    icon: Icons.person_off_outlined,
    activeIcon: Icons.person_off,
    path: '/absences',
    staffOnly: true,
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Calendario',
    icon: Icons.calendar_month_outlined,
    activeIcon: Icons.calendar_month,
    path: '/calendar',
    excludeOtherStaff: true,
  ),
  NavItem(
    label: 'Dirección',
    icon: Icons.admin_panel_settings_outlined,
    activeIcon: Icons.admin_panel_settings,
    path: '/direccion',
    adminOnly: true,
  ),
  NavItem(
    label: 'Mi perfil',
    icon: Icons.person_outlined,
    activeIcon: Icons.person,
    path: '/settings',
  ),
];

List<NavItem> getNavItemsForRole(AppRole? role) {
  return allNavItems.where((item) => item.isVisibleFor(role)).toList();
}

/// Paths that appear in the mobile bottom bar for staff/admin roles.
/// Staff: Inicio, Alumnos, Habitos, Chat + "Mas" overflow.
const _staffPrimaryPaths = {
  '/dashboard',
  '/children',
  '/habits',
  '/chat',
};

/// Paths that appear in the mobile bottom bar for guardians.
/// Guardian: Inicio, Chat, Documentos, Notificaciones, Ajustes.
const _guardianPrimaryPaths = {
  '/dashboard',
  '/chat',
  '/documents',
  '/notifications',
  '/settings',
};

/// Returns the primary bottom-bar items for mobile (role-dependent).
List<NavItem> getPrimaryNavItems(AppRole? role) {
  final all = getNavItemsForRole(role);
  final isGuardian = role == AppRole.guardian;
  final primaryPaths = isGuardian ? _guardianPrimaryPaths : _staffPrimaryPaths;
  return all.where((item) => primaryPaths.contains(item.path)).toList();
}

/// Returns the items that go into the "Mas" overflow sheet on mobile.
List<NavItem> getOverflowNavItems(AppRole? role) {
  final all = getNavItemsForRole(role);
  final primaryPaths = getPrimaryNavItems(role).map((e) => e.path).toSet();
  return all.where((item) => !primaryPaths.contains(item.path)).toList();
}
