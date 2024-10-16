import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/text.dart';
import 'package:once_power/utils/regedit.dart';
import 'package:once_power/utils/utils.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class Global {
  static init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (shortcutMenuExtenderCommand.runIfNeeded(args)) exit(0);

    await PackageDesc.init();

    await StorageUtil.init();
    StorageUtil.remove(AppKeys.apiKey);
    Log.init();
    saveOrNo();

    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(AppNum.defaultW, AppNum.defaultH),
      minimumSize: Size(AppNum.defaultW, AppNum.defaultH),
      center: true,
      title: AppText.name,
      backgroundColor: Colors.transparent,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAsFrameless();
    });

    if (args.isNotEmpty) {
      await StorageUtil.setStringList(AppKeys.folderPathCache, args);
    }
  }
}

void saveOrNo() {
  bool? save = StorageUtil.getBool(AppKeys.isSave) ?? false;
  StorageUtil.remove(AppKeys.matchCache);
  StorageUtil.remove(AppKeys.modifyCache);
  if (!save) {
    List<String> appKeyList = [
      AppKeys.dateLength,
      AppKeys.dateType,
      AppKeys.functionMode,
      AppKeys.isAppend,
      AppKeys.isCase,
      AppKeys.isDate,
      AppKeys.isFolder,
      AppKeys.isViewMode,
      AppKeys.isLength,
      AppKeys.isPrefixCycle,
      AppKeys.isPrefixSwap,
      AppKeys.isSuffixCycle,
      AppKeys.isSuffixSwap,
      AppKeys.isUseRegedit,
      AppKeys.locale,
      AppKeys.prefixLength,
      AppKeys.prefixStart,
      AppKeys.suffixLength,
      AppKeys.suffixStart,
      AppKeys.sortType,
      AppKeys.targetFolder
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
