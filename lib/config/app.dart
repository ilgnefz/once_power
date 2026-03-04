import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/util/storage.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static Future<void> init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (shortcutMenuExtenderCommand.runIfNeeded(args)) exit(0);

    await RustLib.init();

    await StorageUtil.init();

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
