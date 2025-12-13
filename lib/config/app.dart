import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fvp/fvp.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/utils/pack_info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/tray.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (shortcutMenuExtenderCommand.runIfNeeded(args)) exit(0);

    await RustLib.init();

    await PackInfo.init();

    await StorageUtil.init();

    await EasyLocalization.ensureInitialized();

    registerWith(
      options: {
        'platforms': ['windows', 'macos', 'linux'],
      },
    );

    saveOrNo();

    launchAtStartup.setup(
      appName: PackInfo.appName,
      appPath: Platform.resolvedExecutable,
      packageName: AppString.packageName,
    );

    bool powerBoot = await launchAtStartup.isEnabled();

    await windowManager.ensureInitialized();

    double width = AppNum.width, height = AppNum.height;
    bool isCenter = true;
    bool isMaxed = StorageUtil.getBool(AppKeys.isMaxed);

    bool saveSize = StorageUtil.getBool(AppKeys.saveSize);
    if (saveSize && !isMaxed) {
      width = StorageUtil.getDouble(AppKeys.windowWidth) ?? AppNum.width;
      height = StorageUtil.getDouble(AppKeys.windowHeight) ?? AppNum.height;
    }
    bool savePosition = StorageUtil.getBool(AppKeys.savePosition);
    if (savePosition) isCenter = false;

    if (!isCenter) {
      await windowManager.setPosition(Offset(
        StorageUtil.getDouble(AppKeys.windowX) ?? 0,
        StorageUtil.getDouble(AppKeys.windowY) ?? 0,
      ));
    }

    WindowOptions windowOptions = WindowOptions(
      size: Size(width, height),
      minimumSize: Size(AppNum.width, AppNum.height),
      center: isCenter,
      title: AppString.appName,
      backgroundColor: Colors.transparent,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (powerBoot) {
        await windowManager.minimize();
        await windowManager.setSkipTaskbar(true);
        await AppTray.addTray();
      } else {
        await windowManager.show();
        if (isMaxed) await windowManager.maximize();
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
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
