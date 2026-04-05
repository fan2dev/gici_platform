import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import '../data/auth_session_storage.dart';

enum AppRole { platformSuperAdmin, organizationAdmin, staff, guardian }

class AuthState extends Equatable {
  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
    required this.role,
    required this.organizationId,
    required this.actorId,
    required this.email,
    required this.errorMessage,
  });

  const AuthState.unauthenticated()
    : isLoading = false,
      isAuthenticated = false,
      role = null,
      organizationId = null,
      actorId = null,
      email = null,
      errorMessage = null;

  const AuthState.loading()
    : isLoading = true,
      isAuthenticated = false,
      role = null,
      organizationId = null,
      actorId = null,
      email = null,
      errorMessage = null;

  final bool isLoading;
  final bool isAuthenticated;
  final AppRole? role;
  final String? organizationId;
  final String? actorId;
  final String? email;
  final String? errorMessage;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    AppRole? role,
    String? organizationId,
    String? actorId,
    String? email,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      role: role ?? this.role,
      organizationId: organizationId ?? this.organizationId,
      actorId: actorId ?? this.actorId,
      email: email ?? this.email,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isAuthenticated,
    role,
    organizationId,
    actorId,
    email,
    errorMessage,
  ];
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._sessionStorage)
    : super(const AuthState.unauthenticated());

  final AuthRepository _authRepository;
  final AuthSessionStorage _sessionStorage;

  Future<void> bootstrap() async {
    emit(const AuthState.loading());
    final appUserId = await _sessionStorage.readAppUserId();
    if (appUserId == null) {
      emit(const AuthState.unauthenticated());
      return;
    }

    final me = await _authRepository.me(appUserId: appUserId);
    if (me == null) {
      await _sessionStorage.clear();
      emit(const AuthState.unauthenticated());
      return;
    }

    emit(
      AuthState(
        isLoading: false,
        isAuthenticated: true,
        role: _parseRole(me.role),
        organizationId: me.organizationId?.toString(),
        actorId: me.appUserId.toString(),
        email: me.email,
        errorMessage: null,
      ),
    );
  }

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    try {
      final authSession = await _authRepository.signInWithEmailPassword(
        email: email,
        password: password,
      );
      emit(
        AuthState(
          isLoading: false,
          isAuthenticated: true,
          role: _parseRole(authSession.role),
          organizationId: authSession.organizationId?.toString(),
          actorId: authSession.appUserId.toString(),
          email: authSession.email,
          errorMessage: null,
        ),
      );
      await _sessionStorage.saveAppUserId(authSession.appUserId);
    } catch (e) {
      emit(
        const AuthState.unauthenticated().copyWith(
          errorMessage: 'Invalid credentials or backend unavailable.',
        ),
      );
    }
  }

  Future<void> signOut() async {
    await _sessionStorage.clear();
    emit(const AuthState.unauthenticated());
  }

  AppRole _parseRole(String role) {
    switch (role) {
      case 'platform_super_admin':
        return AppRole.platformSuperAdmin;
      case 'organization_admin':
        return AppRole.organizationAdmin;
      case 'staff':
        return AppRole.staff;
      case 'guardian':
      default:
        return AppRole.guardian;
    }
  }
}

extension AuthStateApi on AuthState {
  String get apiRole {
    switch (role) {
      case AppRole.platformSuperAdmin:
        return 'platform_super_admin';
      case AppRole.organizationAdmin:
        return 'organization_admin';
      case AppRole.staff:
        return 'staff';
      case AppRole.guardian:
      case null:
        return 'guardian';
    }
  }
}
