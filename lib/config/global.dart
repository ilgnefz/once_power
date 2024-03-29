import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/utils/utils.dart';
import 'package:window_manager/window_manager.dart';

class Global {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await PackageDesc.init();

    await StorageUtil.init();
    Log.init();
    saveOrNo();

    await windowManager.ensureInitialized();

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
      AppKeys.targetFolder,
      AppKeys.functionMode,
      AppKeys.dateType,
      AppKeys.isLength,
      AppKeys.isCase,
      AppKeys.isDate,
      AppKeys.isPrefixCycle,
      AppKeys.isSuffixCycle,
      AppKeys.isPrefixSwap,
      AppKeys.isSuffixSwap,
      AppKeys.isAppend,
      AppKeys.isFolder,
      AppKeys.dateLength,
      AppKeys.prefixLength,
      AppKeys.prefixStart,
      AppKeys.suffixLength,
      AppKeys.suffixStart,
      AppKeys.sortType,
      AppKeys.locale
    ];
    for (String appKey in appKeyList) {
      StorageUtil.remove(appKey);
    }
  }
}
