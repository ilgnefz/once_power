import 'package:package_info_plus/package_info_plus.dart';

class PackInfo {
  static final PackInfo _instance = PackInfo._();
  factory PackInfo() => _instance;
  static late PackageInfo _packageInfo;

  PackInfo._();

  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get appName => _packageInfo.appName;

  static String getVersion() {
    String number = _packageInfo.buildNumber;
    String version = _packageInfo.version;
    version = number == '0' ? version : '$version.$number';
    return version;
  }
}
