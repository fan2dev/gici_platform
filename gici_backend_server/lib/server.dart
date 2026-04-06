import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  // Initialize Serverpod Auth config before starting
  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      // TODO: Integrate real email provider (SendGrid, SES, etc.)
      print('Validation code for $email: $validationCode');
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      // TODO: Integrate real email provider
      print('Password reset code for ${userInfo.email}: $validationCode');
      return true;
    },
  ));

  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  await pod.start();
}
