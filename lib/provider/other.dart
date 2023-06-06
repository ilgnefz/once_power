import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/global.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/model/values.dart';
import 'package:once_power/model/version.dart';
import 'package:once_power/utils/notification.dart';
import 'package:once_power/utils/storage.dart';

class OtherProvider extends ChangeNotifier {
  bool _currentPage = false;
  bool get currentPage => _currentPage;
  void switchPage(bool value) {
    _currentPage = value;
    notifyListeners();
  }

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
      await StorageUtil().setString(AppValue.language, 'en');
    } else {
      S.load(const Locale('zh', 'CN'));
      await StorageUtil().setString(AppValue.language, 'zh');
    }
    notifyListeners();
  }

  bool _save = Global.save;
  bool get save => _save;
  toggleSave() async {
    _save = !_save;
    // if (!_save) {
    //   StorageUtil().remove(AppValue.caseSensitive);
    //   StorageUtil().remove(AppValue.dateRename);
    //   StorageUtil().remove(AppValue.exchangeSeat);
    //   StorageUtil().remove(AppValue.appendMode);
    //   StorageUtil().remove(AppValue.addFolder);
    //   StorageUtil().remove(AppValue.lowercase);
    //   StorageUtil().remove(AppValue.capital);
    //   StorageUtil().remove(AppValue.digit);
    //   StorageUtil().remove(AppValue.nonLetter);
    //   StorageUtil().remove(AppValue.punctuation);
    //   StorageUtil().remove(AppValue.deleteLength);
    //   StorageUtil().remove(AppValue.prefixNum);
    //   StorageUtil().remove(AppValue.suffixNum);
    //   StorageUtil().remove(AppValue.startNum);
    // }
    await StorageUtil().setBool(AppValue.save, _save);
    notifyListeners();
  }

  bool? _detect;
  bool? get detect => _detect;

  String _latestVersion = '';
  String get latestVersion => _latestVersion;
  String _versionDescZH = '';
  String get versionDescZH => _versionDescZH;
  String _versionDescEN = '';
  String get versionDescEN => _versionDescEN;

  getVersion() async {
    _detect = true;
    notifyListeners();
    try {
      Dio dio = Dio();
      final response = await dio
          .get('https://gitee.com/ilgnefz/once_power/raw/master/version.json');
      VersionInfo versionInfo =
          VersionInfo.fromJson(jsonDecode(response.toString()));
      _latestVersion = versionInfo.info.first.version;
      _versionDescZH = versionInfo.info.first.desc.zh;
      _versionDescEN = versionInfo.info.first.desc.en;
      _detect = false;
    } catch (e) {
      _detect = null;
      NotificationMessage.show(
          S.current.detectError, '$e', MessageType.failure);
    }
    notifyListeners();
  }

  back(BuildContext context) {
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const HomePage()));
    switchPage(false);
    Navigator.of(context).pop();
  }
}
