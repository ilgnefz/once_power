import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/utils/utils.dart';
import 'package:window_manager/window_manager.dart';

class Global {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await PackageDesc.init();

    await StorageUtil.init();
    saveOrNo();

    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1000, 600),
      minimumSize: Size(1000, 600),
      center: true,
      title: 'OncePower',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

void saveOrNo() {
  bool? save = StorageUtil.getBool(AppKeys.isSave) ?? false;
  if (!save) {
    StorageUtil.remove(AppKeys.targetFolder);
    StorageUtil.remove(AppKeys.functionMode);
    StorageUtil.remove(AppKeys.dateType);
    StorageUtil.remove(AppKeys.isLength);
    StorageUtil.remove(AppKeys.isCase);
    StorageUtil.remove(AppKeys.isDate);
    StorageUtil.remove(AppKeys.isPrefixCycle);
    StorageUtil.remove(AppKeys.isSuffixCycle);
    StorageUtil.remove(AppKeys.isPrefixSwap);
    StorageUtil.remove(AppKeys.isSuffixSwap);
    StorageUtil.remove(AppKeys.isAppend);
    StorageUtil.remove(AppKeys.isFolder);
    StorageUtil.remove(AppKeys.dateLength);
    StorageUtil.remove(AppKeys.prefixLength);
    StorageUtil.remove(AppKeys.prefixStart);
    StorageUtil.remove(AppKeys.suffixLength);
    StorageUtil.remove(AppKeys.suffixStart);
    StorageUtil.remove(AppKeys.sortType);
  }
}
