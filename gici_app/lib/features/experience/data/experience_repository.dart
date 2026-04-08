import 'package:gici_backend_client/gici_backend_server_client.dart';

class ExperienceRepository {
  const ExperienceRepository(this._client);

  final Client _client;

  Future<UserOnboardingState?> getOnboardingState() {
    return _client.experience.getOnboardingState();
  }

  Future<UserOnboardingState> completeOnboarding({
    bool acceptTerms = true,
  }) {
    return _client.experience.completeOnboarding(
      acceptTerms: acceptTerms,
    );
  }

  Future<Organization> getCenterInfo() {
    return _client.experience.getCenterInfo();
  }

  Future<List<MenuEntry>> listMenuEntries({
    DateTime? from,
    DateTime? to,
    String? menuTrack,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.experience.listMenuEntries(
      from: from,
      to: to,
      menuTrack: menuTrack,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<MenuEntry> createMenuEntry({
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    String menuTrack = 'normal',
  }) {
    return _client.experience.createMenuEntry(
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      menuTrack: menuTrack,
    );
  }

  Future<MenuEntry> updateMenuEntry({
    required UuidValue menuEntryId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    String? menuTrack,
  }) {
    return _client.experience.updateMenuEntry(
      menuEntryId: menuEntryId,
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      menuTrack: menuTrack,
    );
  }

  Future<int> bulkUploadMonthlyMenu({
    required int year,
    required int month,
    required String menuTrack,
    required List<String> entries,
  }) {
    return _client.experience.bulkUploadMonthlyMenu(
      year: year,
      month: month,
      menuTrack: menuTrack,
      entries: entries,
    );
  }
}
