import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/constant/text.dart';
import 'package:window_manager/window_manager.dart';

class WindowService {
  static Future<void> init() async {
    await windowManager.ensureInitialized();
    double width = AppNumber.width, height = AppNumber.height;
    WindowOptions windowOptions = WindowOptions(
      size: Size(width, height),
      minimumSize: Size(width, height),
      center: true,
      title: AppText.appName,
      titleBarStyle: TitleBarStyle.hidden,
      // backgroundColor: Colors.transparent,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      // if (isMaxed) await windowManager.maximize();
      await windowManager.focus();
      if (!Platform.isMacOS) {
        await windowManager.setAsFrameless();
        await windowManager.setHasShadow(true);
      }
    });
    // final window = WindowManager.instance.getCurrent();
    // if (window == null) return;
    // window.title = AppText.appName;

    // window.setSize(Size(width, height).toNative(), false);
    // window.minimumSize = Size(width, height).toNative();
    // window.titleBarStyle = TitleBarStyle.hidden;
    // window.center();
    // window.show();
    // window.setFrameless(false);
  }
}
