import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/const/images.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/text.dart';
import 'package:tray_manager/tray_manager.dart';

class AppTray {
  static Future<void> addTray() async {
    String icon = Platform.isWindows ? AppImages.logoWin : AppImages.logo;
    await trayManager.setIcon(icon);
    trayManager.setToolTip(AppText.appName);
    Menu menu = Menu(
      items: [
        MenuItem(key: AppKeys.cancelOperate, label: tr(AppL10n.trayCancel)),
        MenuItem(key: AppKeys.showWindow, label: tr(AppL10n.trayShow)),
        MenuItem.separator(),
        MenuItem(key: AppKeys.exitApp, label: tr(AppL10n.trayExit)),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  static Future<void> removeTray() async {
    await trayManager.destroy();
  }
}
