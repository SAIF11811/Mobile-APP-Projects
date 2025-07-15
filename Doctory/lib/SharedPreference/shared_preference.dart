import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String keyRememberMe = 'remember_me';
  static const String keyAgreeToTerms = 'agree_to_terms';

  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setRememberMe(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(keyRememberMe, value);
  }

  static Future<bool> getRememberMe() async {
    final prefs = await _prefs;
    return prefs.getBool(keyRememberMe) ?? false;
  }

  static Future<void> setAgreeToTerms(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(keyAgreeToTerms, value);
  }

  static Future<bool> getAgreeToTerms() async {
    final prefs = await _prefs;
    return prefs.getBool(keyAgreeToTerms) ?? false;
  }

  static Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
