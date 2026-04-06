import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import '../generated/protocol.dart';
import '../helpers/session_user_helper.dart';
import 'password_service.dart';

class AuthService {
  const AuthService({PasswordService passwordService = const PasswordService()})
      : _passwordService = passwordService;

  final PasswordService _passwordService;

  /// Sign in with email and password.
  /// Validates credentials against AppUser, then creates/finds a Serverpod
  /// UserInfo and generates an authentication key for the session.
  Future<AuthSession> signInWithEmailPassword(
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
      throw Exception('Invalid credentials.');
    }

    final valid = _passwordService.verify(
        input: password, hashValue: appUser.passwordHash);
    if (!valid) {
      throw Exception('Invalid credentials.');
    }

    // Ensure Serverpod UserInfo exists and is linked
    int serverpodUserId;
    if (appUser.serverpodUserId != null) {
      serverpodUserId = appUser.serverpodUserId!;
    } else {
      final userInfo =
          await auth.Users.findUserByEmail(session, email.toLowerCase());
      if (userInfo != null) {
        serverpodUserId = userInfo.id!;
      } else {
        final newUserInfo = auth.UserInfo(
          userIdentifier: email.toLowerCase(),
          email: email.toLowerCase(),
          userName: '${appUser.firstName} ${appUser.lastName}',
          created: DateTime.now().toUtc(),
          scopeNames: [],
          blocked: false,
        );
        final created =
            await auth.Users.createUser(session, newUserInfo, 'email');
        if (created == null) {
          throw Exception('Failed to create auth user.');
        }
        serverpodUserId = created.id!;
      }

      // Link AppUser to Serverpod UserInfo
      final linked = appUser.copyWith(serverpodUserId: serverpodUserId);
      await AppUser.db.updateRow(session, linked);
    }

    // Create authentication key (session token) via Serverpod Auth
    final authKey = await auth.UserAuthentication.signInUser(
      session,
      serverpodUserId,
      'email',
      scopes: {},
    );

    // Update last login
    final updatedUser = appUser.copyWith(lastLoginAt: DateTime.now().toUtc());
    await AppUser.db.updateRow(session, updatedUser);

    return AuthSession(
      appUserId: appUser.id!,
      organizationId: appUser.organizationId,
      email: appUser.email,
      role: appUser.role,
      firstName: appUser.firstName,
      lastName: appUser.lastName,
      keyId: authKey.id!,
      key: authKey.key!,
    );
  }

  /// Get current authenticated user's session info.
  Future<AuthSession?> me(Session session) async {
    try {
      final appUser = await getAuthenticatedUser(session);
      return AuthSession(
        appUserId: appUser.id!,
        organizationId: appUser.organizationId,
        email: appUser.email,
        role: appUser.role,
        firstName: appUser.firstName,
        lastName: appUser.lastName,
        keyId: 0,
        key: '',
      );
    } catch (_) {
      return null;
    }
  }

  /// Request a password reset code sent to the user's email.
  Future<bool> requestPasswordReset(
    Session session, {
    required String email,
  }) async {
    // Uses Serverpod Auth's built-in password reset flow
    return await auth.Emails.initiatePasswordReset(
        session, email.toLowerCase());
  }

  /// Reset password using a verification code.
  Future<bool> resetPassword(
    Session session, {
    required String email,
    required String code,
    required String newPassword,
  }) async {
    // Verify code and reset via Serverpod Auth
    final success =
        await auth.Emails.resetPassword(session, code, newPassword);

    if (!success) {
      throw Exception('Invalid or expired verification code.');
    }

    // Also update the password hash in our AppUser table
    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (t) =>
          t.email.equals(email.toLowerCase()) &
          t.deletedAt.equals(null),
    );

    if (appUser != null) {
      final newHash = _passwordService.hash(newPassword);
      final updated = appUser.copyWith(passwordHash: newHash);
      await AppUser.db.updateRow(session, updated);
    }

    return true;
  }
}
