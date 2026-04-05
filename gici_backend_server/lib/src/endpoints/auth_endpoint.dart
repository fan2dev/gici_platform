import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/auth_service.dart';

class AuthEndpoint extends Endpoint {
  AuthEndpoint();

  final _authService = const AuthService();

  Future<AuthSession> signInWithEmailPassword(
    Session session, {
    required String email,
    required String password,
  }) async {
    final authSession = await _authService.signInWithEmailPassword(
      session,
      email: email,
      password: password,
    );

    if (authSession == null) {
      throw Exception('Invalid credentials.');
    }

    return authSession;
  }

  Future<AuthSession?> me(
    Session session, {
    required int appUserId,
  }) {
    return _authService.me(session, appUserId: appUserId);
  }
}
