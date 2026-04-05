import 'package:gici_backend_client/gici_backend_server_client.dart';

class ExperienceRepository {
  const ExperienceRepository(this._client);

  final Client _client;

  Future<UserOnboardingState?> getOnboardingState({
    required String organizationId,
    required String actorId,
  }) {
    return _client.experience.getOnboardingState(
      organizationId: organizationId,
      actorId: actorId,
    );
  }

  Future<UserOnboardingState> completeOnboarding({
    required String organizationId,
    required String actorId,
    bool acceptTerms = true,
  }) {
    return _client.experience.completeOnboarding(
      organizationId: organizationId,
      actorId: actorId,
      acceptTerms: acceptTerms,
    );
  }

  Future<Organization> getCenterInfo({
    required String organizationId,
    required String actorId,
  }) {
    return _client.experience.getCenterInfo(
      organizationId: organizationId,
      actorId: actorId,
    );
  }

  Future<List<MenuEntry>> listMenuEntries({
    required String organizationId,
    required String actorId,
    DateTime? from,
    DateTime? to,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.experience.listMenuEntries(
      organizationId: organizationId,
      actorId: actorId,
      from: from,
      to: to,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<MenuEntry> createMenuEntry({
    required String organizationId,
    required String actorId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
  }) {
    return _client.experience.createMenuEntry(
      organizationId: organizationId,
      actorId: actorId,
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      classroomId: classroomId,
    );
  }
}
