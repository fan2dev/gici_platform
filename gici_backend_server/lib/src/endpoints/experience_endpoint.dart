import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/request_scope.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/experience_service.dart';

class ExperienceEndpoint extends Endpoint {
  ExperienceEndpoint();

  final _accessControl = const AccessControlService();
  final _experienceService = const ExperienceService();
  final _activityLogService = const ActivityLogService();

  Future<UserOnboardingState?> getOnboardingState(
    Session session, {
    required String organizationId,
    required String actorId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    return _experienceService.getOnboardingState(
      session,
      userId: actor.id!,
    );
  }

  Future<UserOnboardingState> completeOnboarding(
    Session session, {
    required String organizationId,
    required String actorId,
    bool acceptTerms = true,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    final onboarding = await _experienceService.completeOnboarding(
      session,
      userId: actor.id!,
      organizationId: orgId,
      acceptTerms: acceptTerms,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'onboarding.complete',
      entityType: 'user_onboarding_state',
      entityId: onboarding.id,
      metadata: 'acceptTerms=$acceptTerms',
    );

    return onboarding;
  }

  Future<Organization> getCenterInfo(
    Session session, {
    required String organizationId,
    required String actorId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    final org = await Organization.db.findFirstRow(
      session,
      where: (t) => t.id.equals(orgId) & t.deletedAt.equals(null),
    );
    if (org == null) {
      throw Exception('Organization not found.');
    }
    return org;
  }

  Future<List<MenuEntry>> listMenuEntries(
    Session session, {
    required String organizationId,
    required String actorId,
    DateTime? from,
    DateTime? to,
    int page = 0,
    int pageSize = 30,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _experienceService.listMenuEntries(
      session,
      organizationId: orgId,
      from: from,
      to: to,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<MenuEntry?> getMenuEntry(
    Session session, {
    required String organizationId,
    required String actorId,
    required int menuEntryId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const [
        'platform_super_admin',
        'organization_admin',
        'staff',
        'guardian',
      ],
    );

    return _experienceService.getMenuEntry(
      session,
      organizationId: orgId,
      menuEntryId: menuEntryId,
    );
  }

  Future<MenuEntry> createMenuEntry(
    Session session, {
    required String organizationId,
    required String actorId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final menuEntry = await _experienceService.createMenuEntry(
      session,
      organizationId: orgId,
      createdByUserId: actor.id!,
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      classroomId: classroomId,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'menu.create',
      entityType: 'menu_entry',
      entityId: menuEntry.id,
      metadata: 'mealType=$mealType;title=$title',
    );

    return menuEntry;
  }

  Future<MenuEntry> updateMenuEntry(
    Session session, {
    required String organizationId,
    required String actorId,
    required int menuEntryId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    int? classroomId,
  }) async {
    final orgId = parseOrganizationId(organizationId);
    final actor = await _accessControl.requireActor(
      session,
      actorId: parseActorId(actorId),
      organizationId: orgId,
      allowedRoles: const ['platform_super_admin', 'organization_admin', 'staff'],
    );

    final existing = await _experienceService.getMenuEntry(
      session,
      organizationId: orgId,
      menuEntryId: menuEntryId,
    );
    if (existing == null) {
      throw Exception('Menu entry not found.');
    }

    final updated = await _experienceService.updateMenuEntry(
      session,
      menuEntry: existing,
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      classroomId: classroomId,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'menu.update',
      entityType: 'menu_entry',
      entityId: updated.id,
      metadata: 'menuEntryId=$menuEntryId',
    );

    return updated;
  }
}
