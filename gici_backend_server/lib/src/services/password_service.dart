import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordService {
  const PasswordService();

  String hash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  bool verify({required String input, required String hashValue}) {
    return hash(input) == hashValue;
  }
}
