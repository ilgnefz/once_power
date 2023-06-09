import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static late SharedPreferences _prefs;

  StorageUtil._();

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  dynamic getString(String key) {
    String? value = _prefs.getString(key);
    return value;
  }

  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    bool? value = _prefs.getBool(key);
    return value;
  }

  Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    int? value = _prefs.getInt(key);
    return value;
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
