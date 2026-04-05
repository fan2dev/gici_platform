import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class HabitRepository {
  const HabitRepository(this._client);

  final Client _client;

  Future<List<MealEntry>> listMealsByChild({
    required UuidValue childId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.habit.listMealsByChild(
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<MealEntry> createMealEntry({
    required UuidValue childId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) {
    return _client.habit.createMealEntry(
      childId: childId,
      mealType: mealType,
      consumptionLevel: consumptionLevel,
      recordedAt: recordedAt,
      menuItems: menuItems,
      notes: notes,
    );
  }

  Future<MealEntry> updateMealEntry({
    required UuidValue mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) {
    return _client.habit.updateMealEntry(
      mealEntryId: mealEntryId,
      mealType: mealType,
      consumptionLevel: consumptionLevel,
      recordedAt: recordedAt,
      menuItems: menuItems,
      notes: notes,
    );
  }

  Future<List<NapEntry>> listNapsByChild({
    required UuidValue childId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.habit.listNapsByChild(
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<NapEntry> createNapEntry({
    required UuidValue childId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) {
    return _client.habit.createNapEntry(
      childId: childId,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      sleepQuality: sleepQuality,
      notes: notes,
    );
  }

  Future<NapEntry> updateNapEntry({
    required UuidValue napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) {
    return _client.habit.updateNapEntry(
      napEntryId: napEntryId,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      sleepQuality: sleepQuality,
      notes: notes,
    );
  }

  Future<List<BowelMovementEntry>> listBowelMovementsByChild({
    required UuidValue childId,
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.habit.listBowelMovementsByChild(
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<BowelMovementEntry> createBowelMovementEntry({
    required UuidValue childId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) {
    return _client.habit.createBowelMovementEntry(
      childId: childId,
      eventAt: eventAt,
      eventType: eventType,
      consistency: consistency,
      notes: notes,
    );
  }

  Future<BowelMovementEntry> updateBowelMovementEntry({
    required UuidValue entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) {
    return _client.habit.updateBowelMovementEntry(
      entryId: entryId,
      eventAt: eventAt,
      eventType: eventType,
      consistency: consistency,
      notes: notes,
    );
  }

  Future<ChildDailyHabits> getChildDailyHabits({
    required UuidValue childId,
    required DateTime day,
  }) {
    return _client.habit.getChildDailyHabits(
      childId: childId,
      day: day,
    );
  }
}
