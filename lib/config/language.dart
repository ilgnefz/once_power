import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/utils/storage.dart';

class LanguageConfig {
  static Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates =
      const [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];
  static Iterable<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('zh', 'CN')
  ];

  static localeResolutionCallback(
      BuildContext context, locale, supportedLocales) {
    Locale? locale = StorageUtil.getLocale(AppKeys.locale);
    if (locale != null) return locale;
    if (locale?.languageCode == 'zh') {
      return const Locale('zh', 'CN');
    }
    return const Locale('en', 'US');
  }
}
