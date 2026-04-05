import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionStorage {
  const AuthSessionStorage();

  static const _appUserIdKey = 'auth_app_user_id';

  Future<void> saveAppUserId(int appUserId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_appUserIdKey, appUserId);
  }

  Future<int?> readAppUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_appUserIdKey);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_appUserIdKey);
  }
}
