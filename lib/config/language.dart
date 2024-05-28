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
      BuildContext context, Locale locale, Iterable<Locale> supportedLocales) {
    Locale? cacheLocale = StorageUtil.getLocale(AppKeys.locale);
    if (cacheLocale != null) return cacheLocale;
    if (locale.languageCode == 'zh') {
      StorageUtil.setLocale(AppKeys.locale, const Locale('zh', 'CN'));
      return const Locale('zh', 'CN');
    }
    StorageUtil.setLocale(AppKeys.locale, const Locale('en', 'US'));
    return const Locale('en', 'US');
  }
}
