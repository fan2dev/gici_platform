import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ExperienceService {
  const ExperienceService();

  Future<UserOnboardingState> completeOnboarding(
    Session session, {
    required UuidValue userId,
    UuidValue? organizationId,
    bool acceptTerms = true,
  }) async {
    final now = DateTime.now().toUtc();
    final existing = await UserOnboardingState.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (existing != null) {
      return UserOnboardingState.db.updateRow(
        session,
        existing.copyWith(
          organizationId: organizationId,
          introCompletedAt: existing.introCompletedAt ?? now,
          termsAcceptedAt: acceptTerms ? (existing.termsAcceptedAt ?? now) : existing.termsAcceptedAt,
          completedAt: now,
          updatedAt: now,
        ),
      );
    }

    return UserOnboardingState.db.insertRow(
      session,
      UserOnboardingState(
        organizationId: organizationId,
        userId: userId,
        introCompletedAt: now,
        termsAcceptedAt: acceptTerms ? now : null,
        completedAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<UserOnboardingState?> getOnboardingState(
    Session session, {
    required UuidValue userId,
  }) {
    return UserOnboardingState.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  Future<List<MenuEntry>> listMenuEntries(
    Session session, {
    required UuidValue organizationId,
    DateTime? from,
    DateTime? to,
    String? menuTrack,
    required int limit,
    required int offset,
  }) async {
    final rows = await MenuEntry.db.find(
      session,
      where: (t) {
        var expr = t.organizationId.equals(organizationId) &
            t.deletedAt.equals(null);
        if (menuTrack != null) {
          expr = expr & t.menuTrack.equals(menuTrack);
        }
        return expr;
      },
      orderBy: (t) => t.menuDate,
      orderDescending: false,
      limit: 2000,
      offset: 0,
    );

    final filtered = rows.where((row) {
      if (from != null && row.menuDate.isBefore(from)) {
        return false;
      }
      if (to != null && row.menuDate.isAfter(to)) {
        return false;
      }
      return true;
    }).toList();

    final start = offset.clamp(0, filtered.length);
    final end = (start + limit).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  Future<MenuEntry> createMenuEntry(
    Session session, {
    required UuidValue organizationId,
    required UuidValue createdByUserId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    String menuTrack = 'normal',
  }) {
    final now = DateTime.now().toUtc();
    return MenuEntry.db.insertRow(
      session,
      MenuEntry(
        organizationId: organizationId,
        menuDate: menuDate,
        menuTrack: menuTrack,
        mealType: mealType,
        title: title,
        description: description,
        createdByUserId: createdByUserId,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
  }

  Future<MenuEntry?> getMenuEntry(
    Session session, {
    required UuidValue organizationId,
    required UuidValue menuEntryId,
  }) {
    return MenuEntry.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(menuEntryId) &
          t.organizationId.equals(organizationId) &
          t.deletedAt.equals(null),
    );
  }

  Future<MenuEntry> updateMenuEntry(
    Session session, {
    required MenuEntry menuEntry,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    String? menuTrack,
  }) {
    return MenuEntry.db.updateRow(
      session,
      menuEntry.copyWith(
        menuDate: menuDate,
        mealType: mealType,
        title: title,
        description: description,
        menuTrack: menuTrack,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// Bulk-create menu entries for an entire month.
  /// Deletes existing entries for the given month, organization, and track,
  /// then inserts all new entries in a single batch.
  Future<List<MenuEntry>> bulkCreateMenuEntries(
    Session session, {
    required UuidValue organizationId,
    required UuidValue createdByUserId,
    required int year,
    required int month,
    required String menuTrack,
    required List<MenuEntry> entries,
  }) async {
    // Determine month boundaries
    final monthStart = DateTime.utc(year, month, 1);
    final monthEnd = DateTime.utc(year, month + 1, 1);

    // Find and soft-delete existing entries for this month + track
    final existing = await MenuEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.menuTrack.equals(menuTrack) &
          t.deletedAt.equals(null),
      limit: 5000,
    );

    final now = DateTime.now().toUtc();
    final toDelete = existing.where((e) =>
        !e.menuDate.isBefore(monthStart) && e.menuDate.isBefore(monthEnd));

    if (toDelete.isNotEmpty) {
      final softDeleted =
          toDelete.map((e) => e.copyWith(deletedAt: now, updatedAt: now)).toList();
      await MenuEntry.db.update(session, softDeleted);
    }

    // Stamp each entry with correct org, track, user, and timestamps
    final stamped = entries.map((e) => MenuEntry(
          organizationId: organizationId,
          menuDate: e.menuDate,
          menuTrack: menuTrack,
          mealType: e.mealType,
          title: e.title,
          description: e.description,
          createdByUserId: createdByUserId,
          createdAt: now,
          updatedAt: now,
        )).toList();

    if (stamped.isEmpty) return [];
    return MenuEntry.db.insert(session, stamped);
  }
}
