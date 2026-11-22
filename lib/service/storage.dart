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

  /// 存取枚举集合：统一存枚举 index 的字符串，兼容旧版数据格式。
  static Future<bool> setEnumSet<T extends Enum>(String key, Set<T> values) =>
      setStringList(key, values.map((e) => e.index.toString()).toList());

  /// 读取枚举集合：按 [values] 的顺序还原，跳过已失效的 index；
  /// 从未存过或数据全失效时回退到 [fallback]。
  static Set<T> getEnumSet<T extends Enum>(
    String key,
    List<T> values, {
    Set<T>? fallback,
  }) {
    final List<String>? stored = _prefs.getStringList(key);
    if (stored == null) return fallback ?? <T>{};
    final Set<T> result = <T>{};
    for (final String item in stored) {
      final int? index = int.tryParse(item);
      if (index != null && index >= 0 && index < values.length) {
        result.add(values[index]);
      }
    }
    return result.isEmpty ? (fallback ?? <T>{}) : result;
  }
}
