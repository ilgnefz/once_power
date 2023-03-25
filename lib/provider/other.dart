import 'package:flutter/material.dart';
import 'package:once_power/model/types.dart';

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
  void toggleLanguage(LanguageType type) {
    _currentLanguage = type;
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
}
