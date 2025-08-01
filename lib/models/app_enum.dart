import 'package:flutter/material.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';

enum FunctionMode { replace, reserve, advance, organize }

extension FunctionModeExtension on FunctionMode {
  String get label {
    switch (this) {
      case FunctionMode.replace:
        return S.current.replace;
      case FunctionMode.reserve:
        return S.current.reserve;
      case FunctionMode.advance:
        return S.current.advance;
      case FunctionMode.organize:
        return S.current.organize;
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

  bool isEnglish() => this == LanguageType.english;
  bool isChinese() => this == LanguageType.chinese;
}

enum NotificationType {
  success(Colors.green, AppIcons.success),
  error(Colors.red, AppIcons.error),
  warning(Colors.orange, AppIcons.warning);

  final Color color;
  final String icon;
  const NotificationType(this.color, this.icon);
}

extension NotificationTypeExtension on NotificationType {
  bool isSuccess() => this == NotificationType.success;
  bool isError() => this == NotificationType.error;
  bool isWarning() => this == NotificationType.warning;
}
