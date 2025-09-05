import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';

enum FunctionMode { replace, reserve, advance, organize }

extension FunctionModeExtension on FunctionMode {
  String get label {
    switch (this) {
      case FunctionMode.replace:
        return tr(AppL10n.functionReplace);
      case FunctionMode.reserve:
        return tr(AppL10n.functionReserve);
      case FunctionMode.advance:
        return tr(AppL10n.functionAdvance);
      case FunctionMode.organize:
        return tr(AppL10n.functionOrganize);
    }
  }

  bool get isOrganize => this == FunctionMode.organize;
  bool get isReserve => this == FunctionMode.reserve;
  bool get isAdvance => this == FunctionMode.advance;
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

  String get label {
    switch (this) {
      case ThemeType.light:
        return tr(AppL10n.themeLight);
      case ThemeType.dark:
        return tr(AppL10n.themeDark);
      case ThemeType.system:
        return tr(AppL10n.themeSystem);
    }
  }

  IconData get icon {
    switch (this) {
      case ThemeType.light:
        return Icons.light_mode_rounded;
      case ThemeType.dark:
        return Icons.dark_mode_rounded;
      case ThemeType.system:
        return Icons.brightness_4_rounded;
    }
  }

  bool get isLight => this == ThemeType.light;
  bool get isDark => this == ThemeType.dark;
  bool get isSystem => this == ThemeType.system;
}
