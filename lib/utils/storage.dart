import 'dart:convert';
import 'dart:ui';

import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/rule_type.dart';
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

  static String? getString(String key) => _prefs.getString(key);

  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static bool? getNullBool(String key) => _prefs.getBool(key);

  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static int? getInt(String key) => _prefs.getInt(key);

  // 存储 List<String>
  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  static List<String> getStringList(String key) {
    List<String>? value = _prefs.getStringList(key);
    return value ?? [];
  }

  static Future<bool> remove(String key) => _prefs.remove(key);

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

  static Future<bool> setRuleTypeValue(String key, RuleTypeValue value) {
    return _prefs.setString(key, jsonEncode(value.toJson()));
  }

  static RuleTypeValue? getRuleTypeValue(String key) {
    String? value = _prefs.getString(key);
    if (value != null) {
      return RuleTypeValue.fromJson(jsonDecode(value));
    }
    return null;
  }
}
