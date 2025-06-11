import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/tray_menu.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/utils/utils.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (shortcutMenuExtenderCommand.runIfNeeded(args)) exit(0);

    await RustLib.init();

    await PackInfo.init();

    await StorageUtil.init();
    StorageUtil.remove(AppKeys.apiKey);
    Log.init();
    saveOrNo();

    VideoPlayerMediaKit.ensureInitialized(
      macOS: true,
      windows: true,
      linux: true,
    );

    launchAtStartup.setup(
      appName: PackInfo.appName,
      appPath: Platform.resolvedExecutable,
      packageName: AppText.packageName,
    );

    bool powerBoot = await launchAtStartup.isEnabled();

    await hotKeyManager.unregisterAll();

    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(AppNum.defaultW, AppNum.defaultH),
      minimumSize: Size(AppNum.defaultW, AppNum.defaultH),
      center: true,
      title: AppText.name,
      backgroundColor: Colors.transparent,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (powerBoot) {
        await windowManager.minimize();
        await windowManager.setSkipTaskbar(true);
        await addTray();
      } else {
        await windowManager.show();
        await windowManager.focus();
      }
      await windowManager.setAsFrameless();
    });

    if (args.isNotEmpty) {
      await StorageUtil.setStringList(AppKeys.rightMenuFolderPath, args);
    }
  }
}

void saveOrNo() {
  bool save = StorageUtil.getBool(AppKeys.isSave);
  StorageUtil.remove(AppKeys.operateLogList);
  StorageUtil.remove(AppKeys.suspenseFileList);
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
      AppKeys.isPrefixCycle,
      AppKeys.isPrefixSwap,
      AppKeys.isUseRuleOrganize,
      AppKeys.isSuffixCycle,
      AppKeys.isSuffixSwap,
      AppKeys.isUseRegex,
      AppKeys.isUseTopFolder,
      AppKeys.isViewMode,
      AppKeys.locale,
      AppKeys.prefixSerialLength,
      AppKeys.prefixSerialStart,
      AppKeys.ruleTypeValue,
      AppKeys.suffixSerialLength,
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
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
