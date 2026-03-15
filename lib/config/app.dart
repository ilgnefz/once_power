import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/util/pack.dart';
import 'package:once_power/util/storage.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static Future<void> init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (shortcutMenuExtenderCommand.runIfNeeded(args)) exit(0);

    await RustLib.init();

    await PackInfo.init();

    await StorageUtil.init();

    saveOrNo();

    await EasyLocalization.ensureInitialized();

    await windowManager.ensureInitialized();

    final Size size = Size(AppNum.width, AppNum.height);

    WindowOptions windowOptions = WindowOptions(
      size: size,
      minimumSize: size,
      center: true,
      title: AppText.appName,
      titleBarStyle: TitleBarStyle.hidden,
      backgroundColor: Colors.transparent,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAsFrameless();
      await windowManager.setHasShadow(true);
    });
  }
}

void saveOrNo() {
  bool save = StorageUtil.getBool(AppKeys.isSave);
  if (!save) {
    List<String> appKeyList = [
      AppKeys.advanceMenuList,
      AppKeys.advancePresetList,
      AppKeys.dateLength,
      AppKeys.dateType,
      AppKeys.functionMode,
      AppKeys.groupList,
      AppKeys.groupFolder,
      AppKeys.isAddFolder,
      AppKeys.isAppend,
      AppKeys.isCase,
      AppKeys.isCaseFile,
      AppKeys.isCaseExtension,
      AppKeys.isDate,
      AppKeys.isLength,
      AppKeys.isCyclePrefix,
      AppKeys.isSwapPrefix,
      AppKeys.isCycleSuffix,
      AppKeys.isSwapSuffix,
      AppKeys.isUseRegex,
      AppKeys.isViewMode,
      AppKeys.locale,
      AppKeys.organizeDate,
      AppKeys.organizeDateFormat,
      AppKeys.organizeDateSeparate,
      AppKeys.prefixSerialLen,
      AppKeys.prefixSerialStart,
      AppKeys.ruleTypeValue,
      AppKeys.suffixSerialLen,
      AppKeys.suffixSerialStart,
      AppKeys.sortType,
      // AppKeys.viewImageW,
      // organize keys
      AppKeys.targetFolder,
      AppKeys.targetFolderList,
      AppKeys.imageFolder,
      AppKeys.imageFolderList,
      AppKeys.videoFolder,
      AppKeys.videoFolderList,
      AppKeys.audioFolder,
      AppKeys.audioFolderList,
      AppKeys.docFolder,
      AppKeys.docFolderList,
      AppKeys.folderFolder,
      AppKeys.folderFolderList,
      AppKeys.zipFolder,
      AppKeys.zipFolderList,
      AppKeys.otherFolder,
      AppKeys.otherFolderList,
      // AppKeys.isUseExtraFunction,
      AppKeys.currentPresetName,
      AppKeys.organizeMode,
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
