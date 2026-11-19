import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/service/storage.dart';

class LanguageConfig {
  /// 与 `LanguageType.values` 顺序一一对应：设置页存的是枚举下标，
  /// 增删语言时这两处必须同步改，否则启动会读到错的语言。
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  static const Locale fallbackLocale = Locale('en', 'US');

  static Future<void> init() async {
    await EasyLocalization.ensureInitialized(
      assetLoader: RootBundleAssetLoader(
        path: 'assets/translations',
        supportedLocales: supportedLocales,
      ),
    );
  }

  static int? get _savedIndex {
    final int? index = StorageService.getInt(AppKeys.language);
    if (index == null || index < 0 || index >= supportedLocales.length) {
      return null;
    }
    return index;
  }

  /// 启动时覆盖系统语言，传给 [EasyLocalization.startLocale]。
  ///
  /// easy_localization 只在使用 `IEasyLocalizationStorage` 时才自己持久化，
  /// 本项目统一把语言存在 [AppKeys.language]，所以这里手动回填：
  /// 返回 null 表示用户没设置过，让库继续跟随系统语言（原行为）。
  static Locale? get startLocale {
    final int? index = _savedIndex;
    return index == null ? null : supportedLocales[index];
  }

  /// 当前应显示的语言，供设置页初始化下拉选中项。
  ///
  /// 优先用保存值；没保存过时按 easy_localization 的匹配规则
  /// （语言码相同且国家码不冲突）从系统语言里挑，匹配不上用 fallback。
  static Locale get initialLocale {
    final Locale? saved = startLocale;
    if (saved != null) return saved;
    final Locale device = PlatformDispatcher.instance.locale;
    for (final Locale locale in supportedLocales) {
      if (locale.languageCode == device.languageCode &&
          (locale.countryCode == null ||
              locale.countryCode!.isEmpty ||
              locale.countryCode == device.countryCode)) {
        return locale;
      }
    }
    return fallbackLocale;
  }
}
