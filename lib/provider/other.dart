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
}
