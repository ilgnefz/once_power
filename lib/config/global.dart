import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/text.dart';
import 'package:once_power/utils/utils.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
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

    VideoPlayerMediaKit.ensureInitialized(
      macOS: true,
      windows: true,
      linux: true,
    );

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
      await StorageUtil.setStringList(AppKeys.rightMenuFolderPath, args);
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
      AppKeys.isCaseClassify,
      AppKeys.isCaseExtension,
      AppKeys.isDate,
      AppKeys.isAddFolder,
      AppKeys.isViewMode,
      AppKeys.isLength,
      AppKeys.isPrefixCycle,
      AppKeys.isPrefixSwap,
      AppKeys.isSuffixCycle,
      AppKeys.isSuffixSwap,
      AppKeys.isUseTopFolder,
      AppKeys.locale,
      AppKeys.prefixLength,
      AppKeys.prefixStart,
      AppKeys.suffixLength,
      AppKeys.suffixStart,
      AppKeys.sortType,
      AppKeys.targetFolder,
      AppKeys.targetFolderList,
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
