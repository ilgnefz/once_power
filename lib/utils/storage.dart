import 'dart:convert';
import 'dart:ui';

import 'package:once_power/model/advance_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static late SharedPreferences _prefs;

  StorageUtil._();

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static String? getString(String key) {
    String? value = _prefs.getString(key);
    return value;
  }

  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    bool? value = _prefs.getBool(key);
    return value;
  }

  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    int? value = _prefs.getInt(key);
    return value;
  }

  // 存储 List<String>
  static Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    List<String>? value = _prefs.getStringList(key);
    return value ?? [];
  }

  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // 存储Locale
  static Future<void> setLocale(String key, Locale value) async {
    String localString = '${value.languageCode}_${value.countryCode}';
    await _prefs.setString(key, localString);
  }

  // 获取Locale
  static Locale? getLocale(String key) {
    Locale? locale;
    String? value = _prefs.getString(key);
    if (value != null) {
      List<String> localeList = value.split('_');
      locale = Locale(localeList[0], localeList[1]);
    }
    return locale;
  }

  // 存储高级规则
  static Future<bool> setAdvanceList(String key, List<AdvanceMenuModel> value) {
    List<String> list = value.map((e) => jsonEncode(e.toJson())).toList();
    return _prefs.setStringList(key, list);
  }

  // 获取高级规则
  static List<AdvanceMenuModel> getAdvanceList(String key) {
    List<String>? list = _prefs.getStringList(key);
    List<AdvanceMenuModel> result = [];
    if (list != null) {
      result = list.map((e) {
        return AdvanceMenuModel.fromJson(jsonDecode(e));
      }).toList();
    }
    return result;
  }

  // 存储预设规则
  static Future<bool> setAdvancePreset(String key, List<AdvancePreset> value) {
    List<String> list = value.map((e) => jsonEncode(e.toJson())).toList();
    return _prefs.setStringList(key, list);
  }

  // 获取预设规则
  static List<AdvancePreset> getAdvancePreset(String key) {
    List<String>? list = _prefs.getStringList(key);
    List<AdvancePreset> result = [];
    if (list != null) {
      result = list.map((e) {
        return AdvancePreset.fromJson(jsonDecode(e));
      }).toList();
    }
    return result;
  }
}
