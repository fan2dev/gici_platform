import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/auth_service.dart';

class AuthEndpoint extends Endpoint {
  final _authService = const AuthService();

  /// Sign in with email and password.
  /// Returns [AuthSession] with user info and creates a session token
  /// that the client will automatically include in subsequent requests.
  Future<AuthSession> signInWithEmailPassword(
    Session session, {
    required String email,
    required String password,
  }) async {
    return await _authService.signInWithEmailPassword(
      session,
      email: email,
      password: password,
    );
  }

  /// Get current authenticated user's session info.
  /// Uses the session token to identify the user — no parameters needed.
  Future<AuthSession?> me(Session session) {
    return _authService.me(session);
  }

  /// Request a password reset code sent to the user's email.
  Future<bool> requestPasswordReset(
    Session session, {
    required String email,
  }) {
    return _authService.requestPasswordReset(session, email: email);
  }

  /// Reset password using a verification code.
  Future<bool> resetPassword(
    Session session, {
    required String email,
    required String code,
    required String newPassword,
  }) {
    return _authService.resetPassword(
      session,
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }
}
