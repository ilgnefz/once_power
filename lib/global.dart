import 'package:flutter/material.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/model/values.dart';
import 'package:once_power/utils/package_info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:window_manager/window_manager.dart';

class Global {
  static late bool save;
  static ModeType? modeType;
  static bool? caseSensitive;
  static bool? dateRename;
  static bool? exchangeSeat;
  static bool? appendMode;
  static bool? addFolder;
  // static bool? lowercase;
  // static bool? capital;
  // static bool? digit;
  // static bool? nonLetter;
  // static bool? punctuation;
  static bool? deleteLength;
  static String? dateLength;
  static String? prefixNum;
  static String? suffixNum;
  static String? startNum;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    await StorageUtil.init();
    await PackageDesc.init();

    WindowOptions options = const WindowOptions(
      size: Size(1000, 600),
      minimumSize: Size(1000, 600),
      center: true,
      title: 'OncePower',
    );

    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    save = StorageUtil().getBool(AppValue.save) ?? false;
    if (save) {
      int? index = StorageUtil().getInt(AppValue.modeType);
      if (index != null) modeType = ModeType.values[index];
      caseSensitive = StorageUtil().getBool(AppValue.caseSensitive);
      dateRename = StorageUtil().getBool(AppValue.dateRename);
      exchangeSeat = StorageUtil().getBool(AppValue.exchangeSeat);
      appendMode = StorageUtil().getBool(AppValue.appendMode);
      addFolder = StorageUtil().getBool(AppValue.addFolder);
      // lowercase = StorageUtil().getBool(AppValue.lowercase);
      // capital = StorageUtil().getBool(AppValue.capital);
      // digit = StorageUtil().getBool(AppValue.digit);
      // nonLetter = StorageUtil().getBool(AppValue.nonLetter);
      // punctuation = StorageUtil().getBool(AppValue.punctuation);
      deleteLength = StorageUtil().getBool(AppValue.deleteLength);
      dateLength = StorageUtil().getString(AppValue.dateLength);
      prefixNum = StorageUtil().getString(AppValue.prefixNum);
      suffixNum = StorageUtil().getString(AppValue.suffixNum);
      startNum = StorageUtil().getString(AppValue.startNum);
    }
  }
}
