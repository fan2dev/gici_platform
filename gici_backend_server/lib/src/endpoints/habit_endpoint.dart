import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/habit_service.dart';

class HabitEndpoint extends Endpoint {
  HabitEndpoint();

  final _accessControl = const AccessControlService();
  final _habitService = const HabitService();
  final _activityLogService = const ActivityLogService();

  Future<void> _ensureChildAccess(
    Session session, {
    required AppUser actor,
    required UuidValue organizationId,
    required UuidValue childId,
  }) async {
    if (actor.role != 'guardian') {
      return;
    }

    final canAccess = await _accessControl.isGuardianOfChild(
      session,
      organizationId: organizationId,
      guardianUserId: actor.id!,
      childId: childId,
    );
    if (!canAccess) {
      throw Exception('Guardian cannot access this child data.');
    }
  }

  Future<List<MealEntry>> listMealsByChild(
    Session session, {
    required UuidValue childId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureChildAccess(
      session,
      actor: actor,
      organizationId: orgId,
      childId: childId,
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);
    return _habitService.listMealsByChild(
      session,
      organizationId: orgId,
      childId: childId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<MealEntry> createMealEntry(
    Session session, {
    required UuidValue childId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _habitService.createMeal(
      session,
      organizationId: orgId,
      childId: childId,
      recordedByUserId: actor.id!,
      mealType: mealType,
      consumptionLevel: consumptionLevel,
      recordedAt: recordedAt,
      menuItems: menuItems,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'habit.meal.create',
      entityType: 'meal_entry',
      entityId: entry.id?.toString(),
      metadata: 'childId=$childId;mealType=$mealType',
    );

    return entry;
  }

  Future<MealEntry> updateMealEntry(
    Session session, {
    required UuidValue mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _habitService.getMealById(
      session,
      mealEntryId: mealEntryId,
    );
    if (entry == null || entry.organizationId != orgId) {
      throw Exception('Meal entry not found.');
    }

    final updated = await _habitService.updateMeal(
      session,
      meal: entry,
      mealType: mealType,
      consumptionLevel: consumptionLevel,
      recordedAt: recordedAt,
      menuItems: menuItems,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'habit.meal.update',
      entityType: 'meal_entry',
      entityId: updated.id?.toString(),
      metadata: 'mealEntryId=$mealEntryId',
    );

    return updated;
  }

  Future<List<NapEntry>> listNapsByChild(
    Session session, {
    required UuidValue childId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureChildAccess(
      session,
      actor: actor,
      organizationId: orgId,
      childId: childId,
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);
    return _habitService.listNapsByChild(
      session,
      organizationId: orgId,
      childId: childId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<NapEntry> createNapEntry(
    Session session, {
    required UuidValue childId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _habitService.createNap(
      session,
      organizationId: orgId,
      childId: childId,
      recordedByUserId: actor.id!,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      sleepQuality: sleepQuality,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'habit.nap.create',
      entityType: 'nap_entry',
      entityId: entry.id?.toString(),
      metadata: 'childId=$childId',
    );

    return entry;
  }

  Future<NapEntry> updateNapEntry(
    Session session, {
    required UuidValue napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _habitService.getNapById(
      session,
      napEntryId: napEntryId,
    );
    if (entry == null || entry.organizationId != orgId) {
      throw Exception('Nap entry not found.');
    }

    final updated = await _habitService.updateNap(
      session,
      nap: entry,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      sleepQuality: sleepQuality,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'habit.nap.update',
      entityType: 'nap_entry',
      entityId: updated.id?.toString(),
      metadata: 'napEntryId=$napEntryId',
    );

    return updated;
  }

  Future<List<BowelMovementEntry>> listBowelMovementsByChild(
    Session session, {
    required UuidValue childId,
    int page = 0,
    int pageSize = 50,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureChildAccess(
      session,
      actor: actor,
      organizationId: orgId,
      childId: childId,
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 200);
    return _habitService.listBowelMovementsByChild(
      session,
      organizationId: orgId,
      childId: childId,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<BowelMovementEntry> createBowelMovementEntry(
    Session session, {
    required UuidValue childId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _habitService.createBowelMovement(
      session,
      organizationId: orgId,
      childId: childId,
      recordedByUserId: actor.id!,
      eventAt: eventAt,
      eventType: eventType,
      consistency: consistency,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'habit.bowel_movement.create',
      entityType: 'bowel_movement_entry',
      entityId: entry.id?.toString(),
      metadata: 'childId=$childId;eventType=$eventType',
    );

    return entry;
  }

  Future<BowelMovementEntry> updateBowelMovementEntry(
    Session session, {
    required UuidValue entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: ['platform_super_admin', 'organization_admin', 'staff']);
    final orgId = actor.organizationId!;

    final entry = await _habitService.getBowelMovementById(
      session,
      entryId: entryId,
    );
    if (entry == null || entry.organizationId != orgId) {
      throw Exception('Bowel movement entry not found.');
    }

    final updated = await _habitService.updateBowelMovement(
      session,
      entry: entry,
      eventAt: eventAt,
      eventType: eventType,
      consistency: consistency,
      notes: notes,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id!,
      action: 'habit.bowel_movement.update',
      entityType: 'bowel_movement_entry',
      entityId: updated.id?.toString(),
      metadata: 'entryId=$entryId',
    );

    return updated;
  }

  Future<ChildDailyHabits> getChildDailyHabits(
    Session session, {
    required UuidValue childId,
    required DateTime day,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    await _ensureChildAccess(
      session,
      actor: actor,
      organizationId: orgId,
      childId: childId,
    );

    return _habitService.getChildDailyHabits(
      session,
      organizationId: orgId,
      childId: childId,
      day: day,
    );
  }
}
