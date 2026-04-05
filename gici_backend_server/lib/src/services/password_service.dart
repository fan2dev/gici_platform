import 'package:bcrypt/bcrypt.dart';

class PasswordService {
  const PasswordService();

  String hash(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool verify({required String input, required String hashValue}) {
    return BCrypt.checkpw(input, hashValue);
  }
}
