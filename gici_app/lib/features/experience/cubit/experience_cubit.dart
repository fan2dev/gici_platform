import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../data/experience_repository.dart';

enum ExperienceStatus { initial, loading, loaded, error }

class ExperienceState extends Equatable {
  const ExperienceState({
    this.status = ExperienceStatus.initial,
    this.centerInfo,
    this.onboardingState,
    this.menuEntries = const [],
    this.errorMessage,
  });

  final ExperienceStatus status;
  final Organization? centerInfo;
  final UserOnboardingState? onboardingState;
  final List<MenuEntry> menuEntries;
  final String? errorMessage;

  bool get isOnboardingComplete => onboardingState?.completedAt != null;

  ExperienceState copyWith({
    ExperienceStatus? status,
    Organization? centerInfo,
    UserOnboardingState? onboardingState,
    List<MenuEntry>? menuEntries,
    String? errorMessage,
  }) {
    return ExperienceState(
      status: status ?? this.status,
      centerInfo: centerInfo ?? this.centerInfo,
      onboardingState: onboardingState ?? this.onboardingState,
      menuEntries: menuEntries ?? this.menuEntries,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        centerInfo,
        onboardingState,
        menuEntries,
        errorMessage,
      ];
}

class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceCubit(this._repository) : super(const ExperienceState());

  final ExperienceRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: ExperienceStatus.loading));

    try {
      final center = await _repository.getCenterInfo();
      final onboarding = await _repository.getOnboardingState();
      final menu = await _repository.listMenuEntries(
        page: 0,
        pageSize: 50,
      );
      emit(state.copyWith(
        status: ExperienceStatus.loaded,
        centerInfo: center,
        onboardingState: onboarding,
        menuEntries: menu,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ExperienceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> completeOnboarding() async {
    try {
      final onboarding = await _repository.completeOnboarding(
        acceptTerms: true,
      );
      emit(state.copyWith(onboardingState: onboarding));
    } catch (e) {
      emit(state.copyWith(
        status: ExperienceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createMenuEntry({
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    UuidValue? classroomId,
  }) async {
    try {
      await _repository.createMenuEntry(
        menuDate: menuDate,
        mealType: mealType,
        title: title,
        description: description,
        classroomId: classroomId,
      );
      await load();
    } catch (e) {
      emit(state.copyWith(
        status: ExperienceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
