import 'package:package_info_plus/package_info_plus.dart';

class PackageDesc {
  static final PackageDesc _instance = PackageDesc._();
  factory PackageDesc() => _instance;
  static late PackageInfo _packageInfo;

  PackageDesc._();

  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String getVersion() => _packageInfo.version;
}
