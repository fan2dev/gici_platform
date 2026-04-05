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
    required int limit,
    required int offset,
  }) async {
    final rows = await MenuEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.deletedAt.equals(null),
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
    UuidValue? classroomId,
  }) {
    final now = DateTime.now().toUtc();
    return MenuEntry.db.insertRow(
      session,
      MenuEntry(
        organizationId: organizationId,
        menuDate: menuDate,
        mealType: mealType,
        title: title,
        description: description,
        classroomId: classroomId,
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
    UuidValue? classroomId,
  }) {
    return MenuEntry.db.updateRow(
      session,
      menuEntry.copyWith(
        menuDate: menuDate,
        mealType: mealType,
        title: title,
        description: description,
        classroomId: classroomId,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
