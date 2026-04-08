import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

import '../data/consent_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class ConsentState extends Equatable {
  const ConsentState({
    this.consents = const [],
    this.isLoading = false,
    this.isActing = false,
    this.errorMessage,
  });

  final List<ConsentRecord> consents;
  final bool isLoading;
  final bool isActing;
  final String? errorMessage;

  ConsentState copyWith({
    List<ConsentRecord>? consents,
    bool? isLoading,
    bool? isActing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ConsentState(
      consents: consents ?? this.consents,
      isLoading: isLoading ?? this.isLoading,
      isActing: isActing ?? this.isActing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        consents,
        isLoading,
        isActing,
        errorMessage,
      ];
}

// ---------------------------------------------------------------------------
// Cubit
// ---------------------------------------------------------------------------

class ConsentCubit extends Cubit<ConsentState> {
  ConsentCubit({
    required ConsentRepository repository,
  })  : _repo = repository,
        super(const ConsentState());

  final ConsentRepository _repo;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final consents = await _repo.getMyConsents();
      emit(state.copyWith(consents: consents, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar consentimientos: $e',
      ));
    }
  }

  Future<bool> accept({
    required String consentType,
    UuidValue? childId,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.acceptConsent(consentType: consentType, childId: childId);
      emit(state.copyWith(isActing: false));
      await load();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al aceptar consentimiento: $e',
      ));
      return false;
    }
  }

  Future<bool> revoke({
    required String consentType,
    UuidValue? childId,
  }) async {
    emit(state.copyWith(isActing: true, clearError: true));
    try {
      await _repo.revokeConsent(consentType: consentType, childId: childId);
      emit(state.copyWith(isActing: false));
      await load();
      return true;
    } catch (e) {
      emit(state.copyWith(
        isActing: false,
        errorMessage: 'Error al revocar consentimiento: $e',
      ));
      return false;
    }
  }
}
