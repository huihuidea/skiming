import 'package:shared_preferences/shared_preferences.dart';
class Storage {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
   _prefs = await SharedPreferences.getInstance();
  }
  static Future<bool> saveToken(String token) async {
   return await _prefs.setString("token", token);
  }
  static String? getToken() {
    return _prefs.getString("token");
  }

  static bool isLogin() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static void cleanToken() async {
    await _prefs.clear();
  }
}