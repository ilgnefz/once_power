import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/utils/utils.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:window_manager/window_manager.dart';

class Global {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await PackageDesc.init();

    await StorageUtil.init();
    Log.init();
    saveOrNo();

    await windowManager.ensureInitialized();

    VideoPlayerMediaKit.ensureInitialized(
      macOS: true,
      windows: true,
      linux: true,
    );

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1016, 616),
      minimumSize: Size(1016, 616),
      center: true,
      title: 'OncePower',
      backgroundColor: Colors.transparent,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAsFrameless();
    });
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
