import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late final SharedPreferences _prefs;

  static Future<bool> remove(String key) => _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static String? getString(String key) => _prefs.getString(key);

  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static bool? getBool(String key) => _prefs.getBool(key);
  static bool getBoolDefault(String key) => _prefs.getBool(key) ?? false;

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static int? getInt(String key) => _prefs.getInt(key);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  static List<String> getStringList(String key) {
    List<String>? value = _prefs.getStringList(key);
    return value ?? [];
  }
}
