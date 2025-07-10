part of 'services.dart';

enum SharedPreferenceKey { idDarkMode }

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> setString(SharedPreferenceKey key, String value) async {
    await _prefs?.setString(key.name, value);
  }

  static String? getString(SharedPreferenceKey key) {
    return _prefs?.getString(key.name);
  }

  static Future<void> setBool(SharedPreferenceKey key, bool value) async {
    await _prefs?.setBool(key.name, value);
  }

  static bool getBool(SharedPreferenceKey key, {bool defaultValue = false}) {
    return _prefs?.getBool(key.name) ?? defaultValue;
  }

  static Future<void> remove(SharedPreferenceKey key) async {
    await _prefs?.remove(key.name);
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
