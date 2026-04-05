import 'package:gici_backend_client/gici_backend_server_client.dart';

class HabitRepository {
  const HabitRepository(this._client);

  final Client _client;

  Future<List<MealEntry>> listMealsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.habit.listMealsByChild(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<MealEntry> createMealEntry({
    required String organizationId,
    required String actorId,
    required int childId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) {
    return _client.habit.createMealEntry(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      mealType: mealType,
      consumptionLevel: consumptionLevel,
      recordedAt: recordedAt,
      menuItems: menuItems,
      notes: notes,
    );
  }

  Future<MealEntry> updateMealEntry({
    required String organizationId,
    required String actorId,
    required int mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) {
    return _client.habit.updateMealEntry(
      organizationId: organizationId,
      actorId: actorId,
      mealEntryId: mealEntryId,
      mealType: mealType,
      consumptionLevel: consumptionLevel,
      recordedAt: recordedAt,
      menuItems: menuItems,
      notes: notes,
    );
  }

  Future<List<NapEntry>> listNapsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.habit.listNapsByChild(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<NapEntry> createNapEntry({
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) {
    return _client.habit.createNapEntry(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      sleepQuality: sleepQuality,
      notes: notes,
    );
  }

  Future<NapEntry> updateNapEntry({
    required String organizationId,
    required String actorId,
    required int napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) {
    return _client.habit.updateNapEntry(
      organizationId: organizationId,
      actorId: actorId,
      napEntryId: napEntryId,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      sleepQuality: sleepQuality,
      notes: notes,
    );
  }

  Future<List<BowelMovementEntry>> listBowelMovementsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.habit.listBowelMovementsByChild(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<BowelMovementEntry> createBowelMovementEntry({
    required String organizationId,
    required String actorId,
    required int childId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) {
    return _client.habit.createBowelMovementEntry(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      eventAt: eventAt,
      eventType: eventType,
      consistency: consistency,
      notes: notes,
    );
  }

  Future<BowelMovementEntry> updateBowelMovementEntry({
    required String organizationId,
    required String actorId,
    required int entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) {
    return _client.habit.updateBowelMovementEntry(
      organizationId: organizationId,
      actorId: actorId,
      entryId: entryId,
      eventAt: eventAt,
      eventType: eventType,
      consistency: consistency,
      notes: notes,
    );
  }

  Future<ChildDailyHabits> getChildDailyHabits({
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime day,
  }) {
    return _client.habit.getChildDailyHabits(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      day: day,
    );
  }
}
