import 'dart:convert';
import 'dart:ui';

import 'package:once_power/models/advance.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/type.dart';
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

  static Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  static double? getDouble(String key) => _prefs.getDouble(key);

  // 存储 List<String>
  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  static List<String> getStringList(String key) {
    List<String>? value = _prefs.getStringList(key);
    return value ?? [];
  }

  // 存储 Map<String, String>
  static Future<bool> setStringMap(String key, Map<String, String> value) {
    String jsonString = jsonEncode(value); // 将 Map 转换为 JSON 字符串
    return _prefs.setString(key, jsonString);
  }

  // 获取 Map<String, String>
  static Map<String, String>? getStringMap(String key) {
    String? jsonString = _prefs.getString(key);
    if (jsonString != null) {
      try {
        // 解析 JSON 并转换为 Map<String, String>
        return Map<String, String>.from(jsonDecode(jsonString));
      } catch (e) {
        // 解析失败时返回空 Map 避免崩溃
        return {};
      }
    }
    return null; // 无存储值时返回空 Map
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

  static Future<bool> setFileList(String key, List<FileInfo> value) {
    List<String> list = value.map((e) => jsonEncode(e.toJson())).toList();
    return _prefs.setStringList(key, list);
  }

  static List<FileInfo> getFileList(String key) {
    List<String>? list = _prefs.getStringList(key);
    List<FileInfo> result = [];
    if (list != null) {
      result = list.map((e) {
        return FileInfo.fromJson(jsonDecode(e));
      }).toList();
    }
    return result;
  }
}
