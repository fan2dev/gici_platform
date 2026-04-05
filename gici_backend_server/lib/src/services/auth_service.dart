import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'password_service.dart';

class AuthService {
  const AuthService({PasswordService passwordService = const PasswordService()})
      : _passwordService = passwordService;

  final PasswordService _passwordService;

  Future<AuthSession?> signInWithEmailPassword(
    Session session, {
    required String email,
    required String password,
  }) async {
    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (t) =>
          t.email.equals(email.toLowerCase()) &
          t.deletedAt.equals(null) &
          t.isActive.equals(true),
    );

    if (appUser == null) {
      return null;
    }

    final valid = _passwordService.verify(
        input: password, hashValue: appUser.passwordHash);
    if (!valid) {
      return null;
    }

    final updated = appUser.copyWith(lastLoginAt: DateTime.now().toUtc());
    await AppUser.db.updateRow(session, updated);

    return AuthSession(
      appUserId: appUser.id!,
      organizationId: appUser.organizationId,
      email: appUser.email,
      role: appUser.role,
      firstName: appUser.firstName,
      lastName: appUser.lastName,
    );
  }

  Future<AuthSession?> me(
    Session session, {
    required int appUserId,
  }) async {
    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null || appUser.deletedAt != null || !appUser.isActive) {
      return null;
    }

    return AuthSession(
      appUserId: appUser.id!,
      organizationId: appUser.organizationId,
      email: appUser.email,
      role: appUser.role,
      firstName: appUser.firstName,
      lastName: appUser.lastName,
    );
  }
}
