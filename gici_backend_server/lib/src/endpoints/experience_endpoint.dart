import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import '../services/access_control_service.dart';
import '../services/activity_log_service.dart';
import '../services/experience_service.dart';

class ExperienceEndpoint extends Endpoint {
  ExperienceEndpoint();

  final _accessControl = const AccessControlService();
  final _experienceService = const ExperienceService();
  final _activityLogService = const ActivityLogService();

  Future<UserOnboardingState?> getOnboardingState(
    Session session,
  ) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);

    return _experienceService.getOnboardingState(
      session,
      userId: actor.id!,
    );
  }

  Future<UserOnboardingState> completeOnboarding(
    Session session, {
    bool acceptTerms = true,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

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
      entityId: onboarding.id?.toString(),
      metadata: 'acceptTerms=$acceptTerms',
    );

    return onboarding;
  }

  Future<Organization> getCenterInfo(
    Session session,
  ) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

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
    DateTime? from,
    DateTime? to,
    String? menuTrack,
    int page = 0,
    int pageSize = 30,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    final safePage = page < 0 ? 0 : page;
    final safePageSize = pageSize.clamp(1, 100);

    return _experienceService.listMenuEntries(
      session,
      organizationId: orgId,
      from: from,
      to: to,
      menuTrack: menuTrack,
      limit: safePageSize,
      offset: safePage * safePageSize,
    );
  }

  Future<MenuEntry?> getMenuEntry(
    Session session, {
    required UuidValue menuEntryId,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
      'guardian',
    ]);
    final orgId = actor.organizationId!;

    return _experienceService.getMenuEntry(
      session,
      organizationId: orgId,
      menuEntryId: menuEntryId,
    );
  }

  Future<MenuEntry> createMenuEntry(
    Session session, {
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    String menuTrack = 'normal',
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

    final menuEntry = await _experienceService.createMenuEntry(
      session,
      organizationId: orgId,
      createdByUserId: actor.id!,
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      menuTrack: menuTrack,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'menu.create',
      entityType: 'menu_entry',
      entityId: menuEntry.id?.toString(),
      metadata: 'mealType=$mealType;title=$title;menuTrack=$menuTrack',
    );

    return menuEntry;
  }

  Future<MenuEntry> updateMenuEntry(
    Session session, {
    required UuidValue menuEntryId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    String? menuTrack,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
      'staff',
    ]);
    final orgId = actor.organizationId!;

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
      menuTrack: menuTrack,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'menu.update',
      entityType: 'menu_entry',
      entityId: updated.id?.toString(),
      metadata: 'menuEntryId=$menuEntryId',
    );

    return updated;
  }

  /// Bulk-upload a full month of menu entries for a given track.
  /// [entries] is a JSON-encoded list where each item has:
  ///   { "date": "2026-04-01", "lunch_first": "...", "lunch_second": "...", "dessert": "..." }
  /// Empty meal strings are skipped (no entry created for that slot).
  Future<int> bulkUploadMonthlyMenu(
    Session session, {
    required int year,
    required int month,
    required String menuTrack,
    required List<String> entries,
  }) async {
    final actor = await getAuthenticatedUser(session);
    _accessControl.requireRole(actor, allowedRoles: const [
      'platform_super_admin',
      'organization_admin',
    ]);
    final orgId = actor.organizationId!;

    // Decode each JSON string into menu entries
    final menuEntries = <MenuEntry>[];
    for (final jsonStr in entries) {
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      final date = DateTime.parse(data['date'] as String);

      final slots = {
        'lunch_first': data['lunch_first'] as String? ?? '',
        'lunch_second': data['lunch_second'] as String? ?? '',
        'dessert': data['dessert'] as String? ?? '',
      };

      for (final entry in slots.entries) {
        final title = entry.value.trim();
        if (title.isEmpty) continue;
        menuEntries.add(MenuEntry(
          organizationId: orgId,
          menuDate: date,
          menuTrack: menuTrack,
          mealType: entry.key,
          title: title,
          createdByUserId: actor.id!,
          createdAt: DateTime.now().toUtc(),
          updatedAt: DateTime.now().toUtc(),
        ));
      }
    }

    final result = await _experienceService.bulkCreateMenuEntries(
      session,
      organizationId: orgId,
      createdByUserId: actor.id!,
      year: year,
      month: month,
      menuTrack: menuTrack,
      entries: menuEntries,
    );

    await _activityLogService.log(
      session,
      organizationId: orgId,
      userId: actor.id,
      action: 'menu.bulk_upload',
      entityType: 'menu_entry',
      metadata: 'year=$year;month=$month;menuTrack=$menuTrack;count=${result.length}',
    );

    return result.length;
  }
}
