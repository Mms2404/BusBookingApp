import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage{
  static const key = 'jwt_token';

  static Future<void> saveToken(String token) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString(key, token);
  }

  static Future<String?> getToken() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(key);
  }

  static Future<void> clearToken(String token) async {
    final preference = await SharedPreferences.getInstance();
    await preference.remove(key);
  }
}