import 'dart:convert';

import 'package:once_power/enum/match.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/setting.dart';
import 'package:once_power/model/type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static late SharedPreferences _prefs;

  StorageUtil._();

  static Future<bool> remove(String key) => _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static String? getString(String key) => _prefs.getString(key);

  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static bool getBool(String key) => _prefs.getBool(key) ?? false;

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

  static Future<bool> setCustomTheme(String key, CustomTheme value) {
    return _prefs.setString(key, jsonEncode(value.toJson()));
  }

  static CustomTheme getCustomTheme(String key) {
    String? value = _prefs.getString(key);
    if (value != null) return CustomTheme.fromJson(jsonDecode(value));
    return CustomTheme();
  }

  // 存储Locale
  // static Future<void> setLocale(String key, Locale value) async {
  //   String localString = '${value.languageCode}_${value.countryCode}';
  //   await _prefs.setString(key, localString);
  // }
  //
  // // 获取Locale
  // static Locale? getLocale(String key) {
  //   Locale? locale;
  //   String? value = _prefs.getString(key);
  //   if (value != null) {
  //     List<String> localeList = value.split('_');
  //     locale = Locale(localeList[0], localeList[1]);
  //   }
  //   return locale;
  // }

  // static Future<bool> setUint8List(String key, Uint8List value) {
  //   String base64String = base64Encode(value);
  //   return _prefs.setString(key, base64String);
  // }

  // static Uint8List? getUint8List(String key) {
  //   String? base64String = _prefs.getString(key);
  //   if (base64String != null) {
  //     try {
  //       return base64Decode(base64String);
  //     } catch (e) {
  //       // 解码失败时返回null
  //       return null;
  //     }
  //   }
  //   return null;
  // }

  // 存储 ReplaceType 数组
  static Future<bool> setReplaceTypeList(String key, List<ReplaceType> value) {
    List<String> list = value.map((e) => e.index.toString()).toList();
    return _prefs.setStringList(key, list);
  }

  // 获取 ReplaceType 数组
  static List<ReplaceType> getReplaceTypeList(String key) {
    List<String>? list = _prefs.getStringList(key);
    if (list == null) return [ReplaceType.match];
    return list.map((e) => ReplaceType.values[int.parse(e)]).toList();
  }

  // 存储 ReserveType 数组
  static Future<bool> setReserveTypeList(String key, List<ReserveType> value) {
    List<String> list = value.map((e) => e.index.toString()).toList();
    return _prefs.setStringList(key, list);
  }

  // 获取 ReserveType 数组
  static List<ReserveType> getReserveTypeList(String key) {
    List<String>? list = _prefs.getStringList(key);
    if (list == null) return [];
    return list.map((e) => ReserveType.values[int.parse(e)]).toList();
  }
}
