import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fvp/fvp.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/util/pack.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/tray.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static Future<void> init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (shortcutMenuExtenderCommand.runIfNeeded(args)) exit(0);

    await RustLib.init();

    await PackInfo.init();

    await StorageUtil.init();

    // await StorageUtil.clear();

    saveOrNo();

    await EasyLocalization.ensureInitialized();

    registerWith(
      options: {
        'platforms': ['windows', 'macos', 'linux'],
      },
    );

    launchAtStartup.setup(
      appName: PackInfo.appName,
      appPath: Platform.resolvedExecutable,
      packageName: AppText.packageName,
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
      await windowManager.setPosition(
        Offset(
          StorageUtil.getDouble(AppKeys.windowX) ?? 0,
          StorageUtil.getDouble(AppKeys.windowY) ?? 0,
        ),
      );
    }

    WindowOptions windowOptions = WindowOptions(
      size: Size(width, height),
      minimumSize: Size(AppNum.width, AppNum.height),
      center: isCenter,
      title: AppText.appName,
      titleBarStyle: TitleBarStyle.hidden,
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
      if (Platform.isWindows) {
        await windowManager.setAsFrameless();
        await windowManager.setHasShadow(true);
      }
    });

    if (args.isNotEmpty) {
      await StorageUtil.setStringList(AppKeys.rightMenuFolderPath, args);
    }
  }
}

void saveOrNo() {
  bool save = StorageUtil.getBool(AppKeys.isSave);
  if (!save) {
    List<String> appKeyList = [
      AppKeys.advanceMenuList,
      AppKeys.advancePresetList,
      AppKeys.presetName,
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
      AppKeys.matchType,
      AppKeys.organizeMode,
      AppKeys.organizeDate,
      AppKeys.organizeDateFormat,
      AppKeys.organizeDateSeparate,
      AppKeys.prefixIndexWidth,
      AppKeys.prefixIndexStart,
      AppKeys.reverseType,
      AppKeys.ruleTypeValue,
      AppKeys.suffixIndexWidth,
      AppKeys.suffixIndexStart,
      AppKeys.sortType,
      AppKeys.targetFolder,
      AppKeys.imageFolder,
      AppKeys.videoFolder,
      AppKeys.audioFolder,
      AppKeys.docFolder,
      AppKeys.folderFolder,
      AppKeys.archiveFolder,
      AppKeys.otherFolder,
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
