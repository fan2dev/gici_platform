import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Retrieves the authenticated [AppUser] from the current session.
///
/// Uses Serverpod's session authentication to get the authenticated user ID,
/// then looks up the corresponding [AppUser] by `serverpodUserId`.
///
/// Throws if:
/// - No authenticated user in session
/// - No matching AppUser found
/// - AppUser is inactive or deleted
Future<AppUser> getAuthenticatedUser(Session session) async {
  final authInfo = await session.authenticated;
  if (authInfo == null) {
    throw Exception('Not authenticated.');
  }

  final serverpodUserId = authInfo.userId;

  final appUser = await AppUser.db.findFirstRow(
    session,
    where: (t) => t.serverpodUserId.equals(serverpodUserId),
  );

  if (appUser == null) {
    throw Exception('User profile not found.');
  }

  if (appUser.deletedAt != null || !appUser.isActive) {
    throw Exception('User account is inactive or deleted.');
  }

  return appUser;
}
