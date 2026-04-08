import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid_value.dart';

import '../../app/shell/app_shell.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/auth/view/forgot_password_page.dart';
import '../../features/chat/view/chat_page.dart';
import '../../features/chat/view/chat_conversation_page.dart';
import '../../features/children/view/child_detail_page.dart';
import '../../features/children/view/children_page.dart';
import '../../features/child_timeline/view/child_timeline_page.dart';
import '../../features/classrooms/view/classrooms_page.dart';
import '../../features/data_change_requests/view/data_change_requests_page.dart';
import '../../features/dashboard/view/dashboard_page.dart';
import '../../features/documents/view/documents_page.dart';
import '../../features/experience/view/experience_page.dart';
import '../../features/experience/view/menu_editor_page.dart';
import '../../features/galleries/view/galleries_page.dart';
import '../../features/habits/view/habits_page.dart';
import '../../features/notifications/view/notifications_page.dart';
import '../../features/pedagogical_reports/view/pedagogical_report_detail_page.dart';
import '../../features/pedagogical_reports/view/pedagogical_reports_page.dart';
import '../../features/parent_preview/view/parent_preview_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/staff_management/view/staff_page.dart';
import '../../features/tariffs/view/tariffs_page.dart';
import '../../features/absences/view/absences_page.dart';
import '../../features/calendar/view/calendar_page.dart';
import '../../features/consent/view/consent_page.dart';
import '../../features/time_tracking/view/time_tracking_page.dart';
import '../../features/direccion/view/direccion_page.dart';
import '../../features/direccion/view/admin_time_tracking_page.dart';

GoRouter buildAppRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final authState = authCubit.state;
      final path = state.uri.path;
      final isLogin = path == '/login' || path == '/forgot-password';

      if (!authState.isAuthenticated && !isLogin) {
        return '/login';
      }
      if (authState.isAuthenticated && isLogin) {
        return '/dashboard';
      }

      // Guardian restrictions
      if (authState.isAuthenticated && authState.isGuardian) {
        if (path.startsWith('/time-tracking') ||
            path.startsWith('/classrooms') ||
            path.startsWith('/staff') ||
            path.startsWith('/tariffs') ||
            path.startsWith('/absences') ||
            path.startsWith('/direccion') ||
            path.startsWith('/menu-editor')) {
          return '/dashboard';
        }
      }

      // Other-staff restrictions: only dashboard, time-tracking, settings
      if (authState.isAuthenticated && authState.isOtherStaff) {
        const allowedPrefixes = ['/dashboard', '/time-tracking', '/settings'];
        final isAllowed = allowedPrefixes.any((p) => path.startsWith(p));
        if (!isAllowed) {
          return '/dashboard';
        }
      }

      return null;
    },
    routes: [
      // Auth routes (outside shell)
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordPage()),

      // App routes (inside shell)
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardPage(),
          ),
          GoRoute(
            path: '/children',
            builder: (_, __) => const ChildrenPage(),
          ),
          GoRoute(
            path: '/children/:childId',
            builder: (_, state) {
              final childId = _parseUuid(state.pathParameters['childId']);
              return childId != null
                  ? ChildDetailPage(childId: childId)
                  : const ChildrenPage();
            },
          ),
          GoRoute(
            path: '/classrooms',
            builder: (_, __) => const ClassroomsPage(),
          ),
          GoRoute(
            path: '/habits',
            builder: (_, __) => const HabitsPage(),
          ),
          GoRoute(
            path: '/chat',
            builder: (_, __) => const ChatPage(),
          ),
          GoRoute(
            path: '/chat/:conversationId',
            builder: (_, state) {
              final id = _parseUuid(state.pathParameters['conversationId']);
              return id != null
                  ? ChatConversationPage(conversationId: id)
                  : const ChatPage();
            },
          ),
          GoRoute(
            path: '/time-tracking',
            builder: (_, __) => const TimeTrackingPage(),
          ),
          GoRoute(
            path: '/notifications',
            builder: (_, __) => const NotificationsPage(),
          ),
          GoRoute(
            path: '/documents',
            builder: (_, __) => const DocumentsPage(),
          ),
          GoRoute(
            path: '/galleries',
            builder: (_, __) => const GalleriesPage(),
          ),
          GoRoute(
            path: '/timeline/:childId',
            builder: (_, state) {
              final childId = _parseUuid(state.pathParameters['childId']);
              return childId != null
                  ? ChildTimelinePage(childId: childId)
                  : const ChildrenPage();
            },
          ),
          GoRoute(
            path: '/reports/:childId',
            builder: (_, state) {
              final childId = _parseUuid(state.pathParameters['childId']);
              return childId != null
                  ? PedagogicalReportsPage(childId: childId)
                  : const ChildrenPage();
            },
          ),
          GoRoute(
            path: '/reports/:childId/:reportId',
            builder: (_, state) {
              final childId = _parseUuid(state.pathParameters['childId']);
              final reportId = _parseUuid(state.pathParameters['reportId']);
              if (childId == null || reportId == null) return const ChildrenPage();
              return PedagogicalReportDetailPage(
                childId: childId,
                reportId: reportId,
              );
            },
          ),
          GoRoute(
            path: '/requests',
            builder: (_, __) => const DataChangeRequestsPage(),
          ),
          GoRoute(
            path: '/experience',
            builder: (_, __) => const ExperiencePage(),
          ),
          GoRoute(
            path: '/menu-editor',
            builder: (_, __) => const MenuEditorPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (_, __) => const SettingsPage(),
          ),
          GoRoute(
            path: '/staff',
            builder: (_, __) => const StaffPage(),
          ),
          GoRoute(
            path: '/tariffs',
            builder: (_, __) => const TariffsPage(),
          ),
          GoRoute(
            path: '/absences',
            builder: (_, __) => const AbsencesPage(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (_, __) => const CalendarPage(),
          ),
          GoRoute(
            path: '/consent',
            builder: (_, __) => const ConsentPage(),
          ),
          GoRoute(
            path: '/direccion',
            builder: (_, __) => const DireccionPage(),
          ),
          GoRoute(
            path: '/direccion/time-tracking',
            builder: (_, __) => const AdminTimeTrackingPage(),
          ),
          GoRoute(
            path: '/parent-preview',
            builder: (_, __) => const ParentPreviewSelectorPage(),
          ),
        ],
      ),
    ],
  );
}

UuidValue? _parseUuid(String? value) {
  if (value == null || value.isEmpty) return null;
  try {
    return UuidValue.fromString(value);
  } catch (_) {
    return null;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
