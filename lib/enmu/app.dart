import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/view/setting/general.dart';
import 'package:once_power/view/setting/log.dart';
import 'package:once_power/view/setting/other.dart';
import 'package:once_power/view/setting/rule.dart';
import 'package:once_power/view/setting/shortcut.dart';
import 'package:once_power/view/setting/appearance.dart';

enum ThemeType { light, dark, system }

extension ThemeTypeExtension on ThemeType {
  ThemeMode get mode {
    switch (this) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      case ThemeType.system:
        return ThemeMode.system;
    }
  }

  // String get label {
  //   switch (this) {
  //     case ThemeType.light:
  //       return tr(AppL10n.light);
  //     case ThemeType.dark:
  //       return tr(AppL10n.dark);
  //     case ThemeType.system:
  //       return tr(AppL10n.system);
  //   }
  // }

  // IconData get icon {
  //   switch (this) {
  //     case ThemeType.light:
  //       return Icons.light_mode_rounded;
  //     case ThemeType.dark:
  //       return Icons.dark_mode_rounded;
  //     case ThemeType.system:
  //       return Icons.brightness_4_rounded;
  //   }
  // }

  Color? get color {
    switch (this) {
      case ThemeType.light:
        return Colors.white;
      case ThemeType.dark:
        return Colors.black;
      case ThemeType.system:
        return null;
    }
  }

  Color? get borderColor {
    switch (this) {
      case ThemeType.light:
        return Colors.white;
      case ThemeType.dark:
        return Colors.black;
      case ThemeType.system:
        return null;
    }
  }

  bool get isLight => this == ThemeType.light;
  bool get isDark => this == ThemeType.dark;
  bool get isSystem => this == ThemeType.system;
}

enum FunctionMode { replace, keep, advanced, organize }

extension FunctionModeExtension on FunctionMode {
  String get label {
    switch (this) {
      case FunctionMode.replace:
        return tr(AppL10n.replace);
      case FunctionMode.keep:
        return tr(AppL10n.keep);
      case FunctionMode.advanced:
        return tr(AppL10n.advanced);
      case FunctionMode.organize:
        return tr(AppL10n.organize);
    }
  }

  bool get isOrganize => this == FunctionMode.organize;
  bool get isKeep => this == FunctionMode.keep;
  bool get isAdvanced => this == FunctionMode.advanced;
  bool get isReplace => this == FunctionMode.replace;
}

enum LanguageType {
  english('English'),
  chinese('中文');

  final String label;
  const LanguageType(this.label);
}

extension LanguageTypeExtension on LanguageType {
  Locale get locale {
    switch (this) {
      case LanguageType.english:
        return const Locale('en', 'US');
      case LanguageType.chinese:
        return const Locale('zh', 'CN');
    }
  }

  bool get isEnglish => this == LanguageType.english;
  bool get isChinese => this == LanguageType.chinese;
}

enum SettingType { rule, general, theme, log, shortcut, other }

extension SettingTypeExtension on SettingType {
  String get label {
    switch (this) {
      case SettingType.rule:
        return tr(AppL10n.rule);
      case SettingType.general:
        return tr(AppL10n.general);
      case SettingType.theme:
        return tr(AppL10n.appearance);
      case SettingType.log:
        return tr(AppL10n.log);
      case SettingType.shortcut:
        return tr(AppL10n.shortcut);
      case SettingType.other:
        return tr(AppL10n.other);
    }
  }

  Widget get view {
    switch (this) {
      case SettingType.rule:
        return const RuleView();
      case SettingType.general:
        return const GeneralView();
      case SettingType.theme:
        return const AppearanceView();
      case SettingType.log:
        return const LogView();
      case SettingType.shortcut:
        return const ShortcutView();
      case SettingType.other:
        return const OtherView();
    }
  }
}
