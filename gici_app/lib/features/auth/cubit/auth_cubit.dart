import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid_value.dart';

import '../data/auth_repository.dart';

enum AppRole { platformSuperAdmin, organizationAdmin, staff, otherStaff, guardian }

class AuthState extends Equatable {
  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
    this.role,
    this.organizationId,
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.errorMessage,
  });

  const AuthState.unauthenticated()
      : isLoading = false,
        isAuthenticated = false,
        role = null,
        organizationId = null,
        userId = null,
        email = null,
        firstName = null,
        lastName = null,
        errorMessage = null;

  const AuthState.loading()
      : isLoading = true,
        isAuthenticated = false,
        role = null,
        organizationId = null,
        userId = null,
        email = null,
        firstName = null,
        lastName = null,
        errorMessage = null;

  final bool isLoading;
  final bool isAuthenticated;
  final AppRole? role;
  final UuidValue? organizationId;
  final UuidValue? userId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? errorMessage;

  bool get isStaffOrAbove =>
      role == AppRole.platformSuperAdmin ||
      role == AppRole.organizationAdmin ||
      role == AppRole.staff ||
      role == AppRole.otherStaff;

  bool get isAdmin =>
      role == AppRole.platformSuperAdmin ||
      role == AppRole.organizationAdmin;

  bool get isGuardian => role == AppRole.guardian;

  bool get isOtherStaff => role == AppRole.otherStaff;

  String get displayName {
    if (firstName != null && lastName != null) return '$firstName $lastName';
    return email ?? '';
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    AppRole? role,
    UuidValue? organizationId,
    UuidValue? userId,
    String? email,
    String? firstName,
    String? lastName,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      role: role ?? this.role,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        role,
        organizationId,
        userId,
        email,
        firstName,
        lastName,
        errorMessage,
      ];
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.unauthenticated());

  final AuthRepository _authRepository;

  /// Try to restore the session from the stored auth key.
  /// Serverpod's FlutterAuthenticationKeyManager handles token persistence.
  Future<void> bootstrap() async {
    emit(const AuthState.loading());

    try {
      final session = await _authRepository.me();
      if (session == null) {
        emit(const AuthState.unauthenticated());
        return;
      }

      emit(AuthState(
        isLoading: false,
        isAuthenticated: true,
        role: _parseRole(session.role),
        organizationId: session.organizationId,
        userId: session.appUserId,
        email: session.email,
        firstName: session.firstName,
        lastName: session.lastName,
      ));
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    try {
      final session = await _authRepository.signInWithEmailPassword(
        email: email,
        password: password,
      );
      emit(AuthState(
        isLoading: false,
        isAuthenticated: true,
        role: _parseRole(session.role),
        organizationId: session.organizationId,
        userId: session.appUserId,
        email: session.email,
        firstName: session.firstName,
        lastName: session.lastName,
      ));
    } catch (e) {
      emit(const AuthState.unauthenticated().copyWith(
        errorMessage: 'Credenciales incorrectas o servidor no disponible.',
      ));
    }
  }

  Future<void> requestPasswordReset({required String email}) async {
    await _authRepository.requestPasswordReset(email: email);
  }

  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      return await _authRepository.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      );
    } catch (_) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
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
      case 'other_staff':
        return AppRole.otherStaff;
      case 'guardian':
      default:
        return AppRole.guardian;
    }
  }
}
