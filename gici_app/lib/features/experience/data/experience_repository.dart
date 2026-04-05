import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

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
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.experience.listMenuEntries(
      from: from,
      to: to,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<MenuEntry> createMenuEntry({
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    UuidValue? classroomId,
  }) {
    return _client.experience.createMenuEntry(
      menuDate: menuDate,
      mealType: mealType,
      title: title,
      description: description,
      classroomId: classroomId,
    );
  }
}
