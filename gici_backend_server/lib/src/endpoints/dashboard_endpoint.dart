import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';

class DashboardEndpoint extends Endpoint {
  final _accessControl = const AccessControlService();

  /// Get a summary of key metrics for the dashboard.
  Future<DashboardSummary> getSummary(Session session) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    // Children count (guardian: only linked children)
    int childrenCount;
    if (actor.role == 'guardian') {
      final relations = await ChildGuardianRelation.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(orgId) &
            t.guardianUserId.equals(actor.id!),
      );
      childrenCount = relations.length;
    } else {
      final children = await Child.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(orgId) &
            t.deletedAt.equals(null) &
            t.status.equals('active'),
      );
      childrenCount = children.length;
    }

    // Classrooms count
    final classrooms = await Classroom.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null) &
          t.status.equals('active'),
    );
    final classroomsCount = classrooms.length;

    // Staff count (admin only)
    int staffCount = 0;
    if (actor.role == 'organization_admin' ||
        actor.role == 'platform_super_admin') {
      final staff = await AppUser.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(orgId) &
            t.deletedAt.equals(null) &
            t.isActive.equals(true) &
            (t.role.equals('staff') | t.role.equals('organization_admin')),
      );
      staffCount = staff.length;
    }

    // Unread notifications
    final unreadNotifs = await NotificationRecord.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.userId.equals(actor.id!) &
          t.isRead.equals(false),
    );
    final unreadNotifications = unreadNotifs.length;

    // Pending data change requests (staff only)
    int pendingRequests = 0;
    if (actor.role != 'guardian') {
      final requests = await DataChangeRequest.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(orgId) & t.status.equals('pending'),
      );
      pendingRequests = requests.length;
    }

    // Today's menu
    final now = DateTime.now().toUtc();
    final todayStart = DateTime.utc(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));
    final todayMenu = await MenuEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null) &
          t.menuDate.between(todayStart, todayEnd),
      orderBy: (t) => t.mealType,
    );

    // Today's calendar events
    final todayEvents = await SchoolCalendarEvent.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          t.deletedAt.equals(null) &
          t.eventDate.between(todayStart, todayEnd),
      orderBy: (t) => t.eventDate,
    );

    // Recent notifications (last 5)
    final recentNotifs = await NotificationRecord.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) & t.userId.equals(actor.id!),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 5,
    );

    return DashboardSummary(
      childrenCount: childrenCount,
      classroomsCount: classroomsCount,
      staffCount: staffCount,
      unreadNotifications: unreadNotifications,
      pendingRequests: pendingRequests,
      todayMenuEntries: todayMenu,
      todayEvents: todayEvents,
      recentNotifications: recentNotifs,
    );
  }
}
