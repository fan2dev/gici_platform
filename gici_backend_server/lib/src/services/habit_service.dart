import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class HabitService {
  const HabitService();

  DateTime _dayStartUtc(DateTime day) {
    final utc = day.toUtc();
    return DateTime.utc(utc.year, utc.month, utc.day);
  }

  DateTime _dayEndUtc(DateTime day) {
    return _dayStartUtc(day).add(const Duration(days: 1));
  }

  Future<List<MealEntry>> listMealsByChild(
    Session session, {
    required int organizationId,
    required int childId,
    required int limit,
    required int offset,
  }) {
    return MealEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<MealEntry?> getMealById(
    Session session, {
    required int mealEntryId,
  }) {
    return MealEntry.db.findById(session, mealEntryId);
  }

  Future<MealEntry> createMeal(
    Session session, {
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) {
    final now = DateTime.now().toUtc();
    return MealEntry.db.insertRow(
      session,
      MealEntry(
        organizationId: organizationId,
        childId: childId,
        recordedByUserId: recordedByUserId,
        mealType: mealType,
        consumptionLevel: consumptionLevel,
        recordedAt: recordedAt ?? now,
        menuItems: menuItems,
        notes: notes,
        photoUrl: null,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<MealEntry> updateMeal(
    Session session, {
    required MealEntry meal,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) {
    return MealEntry.db.updateRow(
      session,
      meal.copyWith(
        mealType: mealType,
        consumptionLevel: consumptionLevel,
        recordedAt: recordedAt,
        menuItems: menuItems,
        notes: notes,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<NapEntry>> listNapsByChild(
    Session session, {
    required int organizationId,
    required int childId,
    required int limit,
    required int offset,
  }) {
    return NapEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.startedAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<NapEntry?> getNapById(
    Session session, {
    required int napEntryId,
  }) {
    return NapEntry.db.findById(session, napEntryId);
  }

  Future<NapEntry> createNap(
    Session session, {
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) {
    final now = DateTime.now().toUtc();
    return NapEntry.db.insertRow(
      session,
      NapEntry(
        organizationId: organizationId,
        childId: childId,
        recordedByUserId: recordedByUserId,
        startedAt: startedAt,
        endedAt: endedAt,
        durationMinutes: durationMinutes,
        sleepQuality: sleepQuality,
        notes: notes,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<NapEntry> updateNap(
    Session session, {
    required NapEntry nap,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) {
    return NapEntry.db.updateRow(
      session,
      nap.copyWith(
        startedAt: startedAt,
        endedAt: endedAt,
        durationMinutes: durationMinutes,
        sleepQuality: sleepQuality,
        notes: notes,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<BowelMovementEntry>> listBowelMovementsByChild(
    Session session, {
    required int organizationId,
    required int childId,
    required int limit,
    required int offset,
  }) {
    return BowelMovementEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.eventAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<BowelMovementEntry?> getBowelMovementById(
    Session session, {
    required int entryId,
  }) {
    return BowelMovementEntry.db.findById(session, entryId);
  }

  Future<BowelMovementEntry> createBowelMovement(
    Session session, {
    required int organizationId,
    required int childId,
    required int recordedByUserId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) {
    final now = DateTime.now().toUtc();
    return BowelMovementEntry.db.insertRow(
      session,
      BowelMovementEntry(
        organizationId: organizationId,
        childId: childId,
        recordedByUserId: recordedByUserId,
        eventAt: eventAt ?? now,
        eventType: eventType,
        consistency: consistency,
        notes: notes,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<BowelMovementEntry> updateBowelMovement(
    Session session, {
    required BowelMovementEntry entry,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) {
    return BowelMovementEntry.db.updateRow(
      session,
      entry.copyWith(
        eventAt: eventAt,
        eventType: eventType,
        consistency: consistency,
        notes: notes,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<ChildDailyHabits> getChildDailyHabits(
    Session session, {
    required int organizationId,
    required int childId,
    required DateTime day,
  }) async {
    final start = _dayStartUtc(day);
    final end = _dayEndUtc(day);

    final mealsRaw = await MealEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: 500,
    );
    final napsRaw = await NapEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.startedAt,
      orderDescending: true,
      limit: 500,
    );
    final bowelRaw = await BowelMovementEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.eventAt,
      orderDescending: true,
      limit: 500,
    );

    final meals = mealsRaw
        .where((e) => !e.recordedAt.isBefore(start) && e.recordedAt.isBefore(end))
        .toList();
    final naps = napsRaw
        .where((e) => !e.startedAt.isBefore(start) && e.startedAt.isBefore(end))
        .toList();
    final bowelMovements = bowelRaw
        .where((e) => !e.eventAt.isBefore(start) && e.eventAt.isBefore(end))
        .toList();

    return ChildDailyHabits(
      childId: childId,
      day: start,
      meals: meals,
      naps: naps,
      bowelMovements: bowelMovements,
    );
  }
}
