import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/tray.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class AutoRunBtn extends ConsumerStatefulWidget {
  const AutoRunBtn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PowerBootBtnState();
}

class _PowerBootBtnState extends ConsumerState<AutoRunBtn> with TrayListener {
  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  @override
  void onTrayIconMouseDown() {
    windowManager.setSkipTaskbar(false);
    windowManager.show();
    windowManager.focus();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    if (menuItem.key == AppKeys.showWindow) {
      await windowManager.setSkipTaskbar(false);
      await windowManager.show();
      await windowManager.focus();
    } else if (menuItem.key == AppKeys.autoRun) {
      ref.read(isAutoRunProvider.notifier).update();
    } else if (menuItem.key == AppKeys.exitApp) {
      await windowManager.destroy();
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> toggleView() async {
      bool isEnabled = await launchAtStartup.isEnabled();
      bool cacheEnabled = ref.watch(isAutoRunProvider);
      if (isEnabled != cacheEnabled) {
        return ref.read(isAutoRunProvider.notifier).update();
      }
      if (isEnabled) await launchAtStartup.disable();
      if (!isEnabled) await launchAtStartup.enable();
      ref.read(isAutoRunProvider.notifier).update();
      if (ref.watch(isAutoRunProvider)) {
        await AppTray.addTray();
      } else {
        await AppTray.removeTray();
      }
    }

    return TooltipIcon(
      tip: tr(AppL10n.bottomAutoRun),
      svg: AppIcons.autoRun,
      selected: ref.watch(isAutoRunProvider),
      onPressed: toggleView,
    );
  }
}
