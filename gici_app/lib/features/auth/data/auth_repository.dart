import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class AuthRepository {
  const AuthRepository(this._client);

  final Client _client;

  /// Sign in and store the auth key for subsequent requests.
  Future<AuthSession> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final session = await _client.auth.signInWithEmailPassword(
      email: email,
      password: password,
    );

    // Store the auth key so FlutterAuthenticationKeyManager includes it
    // in all subsequent requests. Format: "keyId:key"
    final keyManager = _client.authenticationKeyManager;
    if (keyManager is FlutterAuthenticationKeyManager) {
      await keyManager.put('${session.keyId}:${session.key}');
    }

    return session;
  }

  /// Get current authenticated user session.
  Future<AuthSession?> me() {
    return _client.auth.me();
  }

  Future<bool> requestPasswordReset({required String email}) {
    return _client.auth.requestPasswordReset(email: email);
  }

  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return _client.auth.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }

  Future<void> signOut() async {
    final keyManager = _client.authenticationKeyManager;
    if (keyManager is FlutterAuthenticationKeyManager) {
      await keyManager.remove();
    }
  }
}
