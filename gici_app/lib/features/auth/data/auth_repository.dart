import 'package:gici_backend_client/gici_backend_server_client.dart';

class AuthRepository {
  const AuthRepository(this._client);

  final Client _client;

  Future<AuthSession> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthSession?> me({required int appUserId}) {
    return _client.auth.me(appUserId: appUserId);
  }
}
