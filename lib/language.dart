import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/utils/storage.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'model/types.dart';

class LanguageManager {
  static Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates =
      const [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static Iterable<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  static localeResolutionCallback(
      BuildContext context, locale, supportedLocales) {
    if (StorageUtil().getString('language') != null) {
      if (StorageUtil().getString('language') == 'zh') {
        context.watch<OtherProvider>().toggleLanguage(LanguageType.chinese);
        return const Locale('zh', 'CN');
      }
      return const Locale('en', 'US');
    }
    if (locale?.languageCode == 'zh') {
      context.watch<OtherProvider>().toggleLanguage(LanguageType.chinese);
      return const Locale('zh', 'CN');
    }
    return const Locale('en', 'US');
  }
}
