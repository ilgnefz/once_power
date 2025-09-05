import 'dart:ui';

class LanguageConfig {
  static List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];
  static String path = 'assets/translations';
  static Locale? fallbackLocale = Locale('en', 'US');
}
