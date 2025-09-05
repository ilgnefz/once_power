import 'dart:io';

import 'package:once_power/constants/images.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/string.dart';
import 'package:tray_manager/tray_manager.dart';

class AppTray {
  static Future<void> addTray() async {
    String icon = Platform.isWindows ? AppImages.logoWin : AppImages.logo;
    await trayManager.setIcon(icon);
    trayManager.setToolTip(AppString.appName);
    // TODO: 翻译
    Menu menu = Menu(
      items: [
        MenuItem(key: AppKeys.cancelOperate, label: 'cancelOperation'),
        MenuItem(key: AppKeys.showWindow, label: 'showWindow'),
        MenuItem.separator(),
        MenuItem(key: AppKeys.exitApp, label: 'exitApp'),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  static Future<void> removeTray() async {
    await trayManager.destroy();
  }
}
