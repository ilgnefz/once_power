import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/language.dart';
import 'package:once_power/service/package.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/service/window.dart';

class AppConfig {
  static Future<void> init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();
    await StorageService.init();
    await LanguageConfig.init();
    await PackageService.init();
    await WindowService.init();
  }
}
