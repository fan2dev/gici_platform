import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/view/login_page.dart';
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
import '../../features/galleries/view/galleries_page.dart';
import '../../features/habits/view/habits_page.dart';
import '../../features/notifications/view/notifications_page.dart';
import '../../features/pedagogical_reports/view/pedagogical_report_detail_page.dart';
import '../../features/pedagogical_reports/view/pedagogical_reports_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/time_tracking/view/time_tracking_page.dart';

GoRouter buildAppRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final authState = authCubit.state;
      final isLogin = state.uri.path == '/login';
      final isTimeTracking = state.uri.path.startsWith('/time-tracking');
      final isClassrooms = state.uri.path.startsWith('/classrooms');
      final isChildren = state.uri.path.startsWith('/children');
      final isHabits = state.uri.path.startsWith('/habits');
      final isTimeline = state.uri.path.startsWith('/timeline');
      final isReports = state.uri.path.startsWith('/reports');
      final isRequests = state.uri.path.startsWith('/requests');
      final isDocuments = state.uri.path.startsWith('/documents');
      final isGalleries = state.uri.path.startsWith('/galleries');
      final isNotifications = state.uri.path.startsWith('/notifications');
      final isExperience = state.uri.path.startsWith('/experience');

      if (!authState.isAuthenticated && !isLogin) {
        return '/login';
      }
      if (authState.isAuthenticated && isLogin) {
        return '/dashboard';
      }

      if (authState.isAuthenticated &&
          authState.role == AppRole.guardian &&
          (isTimeTracking || isClassrooms)) {
        return '/dashboard';
      }

      if (authState.isAuthenticated &&
          authState.role == null &&
          (isTimeTracking ||
              isClassrooms ||
              isChildren ||
              isHabits ||
              isTimeline ||
              isReports ||
              isRequests ||
              isDocuments ||
              isGalleries ||
              isNotifications ||
              isExperience)) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) =>
            DashboardPage(isWebEntry: kIsWeb, role: authCubit.state.role),
      ),
      GoRoute(
        path: '/time-tracking',
        builder: (context, state) => const TimeTrackingPage(),
      ),
      GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
      GoRoute(
        path: '/chat/:conversationId',
        builder: (context, state) {
          final conversationId = int.tryParse(
            state.pathParameters['conversationId'] ?? '',
          );
          if (conversationId == null) {
            return const ChatPage();
          }
          return ChatConversationPage(conversationId: conversationId);
        },
      ),
      GoRoute(
        path: '/children',
        builder: (context, state) => const ChildrenPage(),
      ),
      GoRoute(
        path: '/children/:childId',
        builder: (context, state) {
          final childId = int.tryParse(state.pathParameters['childId'] ?? '');
          if (childId == null) {
            return const LoginPage();
          }
          return ChildDetailPage(childId: childId);
        },
      ),
      GoRoute(
        path: '/classrooms',
        builder: (context, state) => const ClassroomsPage(),
      ),
      GoRoute(path: '/habits', builder: (context, state) => const HabitsPage()),
      GoRoute(
        path: '/timeline/:childId',
        builder: (context, state) {
          final childId = int.tryParse(state.pathParameters['childId'] ?? '');
          if (childId == null) {
            return const ChildrenPage();
          }
          return ChildTimelinePage(childId: childId);
        },
      ),
      GoRoute(
        path: '/reports/:childId',
        builder: (context, state) {
          final childId = int.tryParse(state.pathParameters['childId'] ?? '');
          if (childId == null) {
            return const ChildrenPage();
          }
          return PedagogicalReportsPage(childId: childId);
        },
      ),
      GoRoute(
        path: '/reports/:childId/:reportId',
        builder: (context, state) {
          final childId = int.tryParse(state.pathParameters['childId'] ?? '');
          final reportId = int.tryParse(state.pathParameters['reportId'] ?? '');
          if (childId == null || reportId == null) {
            return const ChildrenPage();
          }
          return PedagogicalReportDetailPage(
            childId: childId,
            reportId: reportId,
          );
        },
      ),
      GoRoute(
        path: '/requests',
        builder: (context, state) => const DataChangeRequestsPage(),
      ),
      GoRoute(
        path: '/documents',
        builder: (context, state) => const DocumentsPage(),
      ),
      GoRoute(
        path: '/galleries',
        builder: (context, state) => const GalleriesPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/experience',
        builder: (context, state) => const ExperiencePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
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
