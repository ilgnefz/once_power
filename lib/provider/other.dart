import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/utils/storage.dart';

class OtherProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void toggleIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<LanguageType> languageList = [
    LanguageType.chinese,
    LanguageType.english,
  ];
  LanguageType _currentLanguage = LanguageType.english;
  LanguageType get currentLanguage => _currentLanguage;
  void toggleLanguage(LanguageType type) async {
    _currentLanguage = type;
    if (type == LanguageType.english) {
      S.load(const Locale('en', 'US'));
      await StorageUtil().setString('language', 'en');
    } else {
      S.load(const Locale('zh', 'CN'));
      await StorageUtil().setString('language', 'zh');
    }
    notifyListeners();
  }

  final List<ThemeType> themeList = [
    ThemeType.light,
    ThemeType.dark,
    ThemeType.system,
  ];

  ThemeType _currentTheme = ThemeType.light;
  ThemeType get currentTheme => _currentTheme;
  void toggleTheme(ThemeType type) {
    _currentTheme = type;
    notifyListeners();
  }

  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  ThemeMode get currentThemeMode {
    if (_currentTheme == ThemeType.light) return ThemeMode.light;
    if (_currentTheme == ThemeType.dark) return ThemeMode.dark;
    return ThemeMode.system;
  }
}
