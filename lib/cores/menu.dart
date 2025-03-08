import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/content_bar/right_click_menu.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

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

Future<void> showRightMenu(
  BuildContext context,
  WidgetRef ref,
  TapDownDetails details,
  FileInfo e,
) async {
  const double safeW = 12, safeH = 32;
  Locale? loe = StorageUtil.getLocale(AppKeys.locale);
  double width = loe?.languageCode != 'zh' ? 120 : 80, height = safeH * 8;
  Size size = await windowManager.getSize();
  // debugPrint('窗口尺寸：$size，鼠标坐标：${details.globalPosition}');
  if (!context.mounted) return;
  showModal(
    context: context,
    configuration: const FadeScaleTransitionConfiguration(
      barrierColor: Colors.transparent,
    ),
    builder: (BuildContext context) {
      double x = details.globalPosition.dx;
      double y = details.globalPosition.dy;
      if (x + width > size.width - safeW) x -= width;
      if (y + height > size.height - safeH) y -= height;
      return RightClickMenu(width: width, height: height, x: x, y: y, e: e);
    },
  );
}
