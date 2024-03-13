import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/utils/storage.dart';

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
    //   if (StorageUtil.getString(AppKeys.language) != null) {
    //     if (StorageUtil.getString(AppKeys.language) == 'zh') {
    //       // context.watch<OtherProvider>().toggleLanguage(LanguageType.chinese);
    //       return const Locale('zh', 'CN');
    //     }
    //     return const Locale('en', 'US');
    //   }
    //   if (locale?.languageCode == 'zh') {
    //     // context.watch<OtherProvider>().toggleLanguage(LanguageType.chinese);
    //     return const Locale('zh', 'CN');
    //   }
    //   return const Locale('en', 'US');
    // }
    return const Locale('en', 'US');
  }
}
