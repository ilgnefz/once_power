import 'dart:io';

import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:tray_manager/tray_manager.dart';

Future<void> addTray() async {
  String icon = Platform.isWindows ? AppImages.logoWin : AppImages.logo;
  await trayManager.setIcon(icon);
  trayManager.setToolTip(AppText.name);
  Menu menu = Menu(
    items: [
      MenuItem(key: AppKeys.cancelOperate, label: S.current.cancelOperation),
      MenuItem(key: AppKeys.showWindow, label: S.current.showWindow),
      MenuItem.separator(),
      MenuItem(key: AppKeys.exitApp, label: S.current.exitApp),
    ],
  );
  await trayManager.setContextMenu(menu);
}

Future<void> removeTray() async {
  await trayManager.destroy();
}
