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
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String path;
  final bool staffOnly;
  final bool adminOnly;
  final bool guardianOnly;

  bool isVisibleFor(AppRole? role) {
    if (role == null) return false;
    if (adminOnly && role != AppRole.organizationAdmin && role != AppRole.platformSuperAdmin) {
      return false;
    }
    if (staffOnly && role == AppRole.guardian) return false;
    if (guardianOnly && role != AppRole.guardian) return false;
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
  NavItem(
    label: 'Alumnos',
    icon: Icons.child_care_outlined,
    activeIcon: Icons.child_care,
    path: '/children',
  ),
  NavItem(
    label: 'Aulas',
    icon: Icons.meeting_room_outlined,
    activeIcon: Icons.meeting_room,
    path: '/classrooms',
    staffOnly: true,
  ),
  NavItem(
    label: 'Hábitos',
    icon: Icons.restaurant_outlined,
    activeIcon: Icons.restaurant,
    path: '/habits',
  ),
  NavItem(
    label: 'Chat',
    icon: Icons.chat_outlined,
    activeIcon: Icons.chat,
    path: '/chat',
  ),
  NavItem(
    label: 'Horario',
    icon: Icons.access_time_outlined,
    activeIcon: Icons.access_time_filled,
    path: '/time-tracking',
    staffOnly: true,
  ),
  NavItem(
    label: 'Notificaciones',
    icon: Icons.notifications_outlined,
    activeIcon: Icons.notifications,
    path: '/notifications',
  ),
  NavItem(
    label: 'Documentos',
    icon: Icons.description_outlined,
    activeIcon: Icons.description,
    path: '/documents',
  ),
  NavItem(
    label: 'Galerías',
    icon: Icons.photo_library_outlined,
    activeIcon: Icons.photo_library,
    path: '/galleries',
  ),
  NavItem(
    label: 'Solicitudes',
    icon: Icons.edit_note_outlined,
    activeIcon: Icons.edit_note,
    path: '/requests',
  ),
  NavItem(
    label: 'Centro',
    icon: Icons.info_outlined,
    activeIcon: Icons.info,
    path: '/experience',
  ),
  NavItem(
    label: 'Personal',
    icon: Icons.people_outlined,
    activeIcon: Icons.people,
    path: '/staff',
    adminOnly: true,
  ),
  NavItem(
    label: 'Ajustes',
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings,
    path: '/settings',
  ),
];

List<NavItem> getNavItemsForRole(AppRole? role) {
  return allNavItems.where((item) => item.isVisibleFor(role)).toList();
}
