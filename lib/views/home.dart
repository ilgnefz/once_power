import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/provider/theme.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/regedit.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action/action.dart';
import 'package:once_power/views/bottom/bottom.dart';
import 'package:once_power/views/content/content.dart';
import 'package:once_power/views/title_bar.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WindowListener, ShortcutMenuListener {
  void _init() async {
    await windowManager.setPreventClose(true);
    bool useRegedit = StorageUtil.getBool(AppKeys.isUseRegedit);
    if (useRegedit) {
      AppRegedit.removeGlobalRegedit();
      AppRegedit.createLocalRegedit();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    shortcutMenuExtender.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    shortcutMenuExtender.removeListener(this);
    super.dispose();
  }

  Future<void> minimizeWindow() async {
    await windowManager.setSkipTaskbar(true);
    await windowManager.hide();
  }

  Future<void> closeWindow() async {
    toggleRegedit();
    await windowManager.destroy();
    exit(0);
  }

  @override
  void onWindowResized() async {
    bool saveSize = StorageUtil.getBool(AppKeys.saveSize);
    if (saveSize) {
      Size size = await windowManager.getSize();
      await StorageUtil.setDouble(AppKeys.windowWidth, size.width);
      await StorageUtil.setDouble(AppKeys.windowHeight, size.height);
    }
  }

  @override
  void onWindowMoved() async {
    bool savePosition = StorageUtil.getBool(AppKeys.savePosition);
    if (savePosition) {
      Offset position = await windowManager.getPosition();
      await StorageUtil.setDouble(AppKeys.windowX, position.dx);
      await StorageUtil.setDouble(AppKeys.windowY, position.dy);
    }
  }

  void toggleRegedit() {
    if (StorageUtil.getBool(AppKeys.isUseRegedit)) {
      AppRegedit.removeLocalRegedit();
      AppRegedit.createGlobalRegedit();
    }
  }

  @override
  void onWindowClose() async {
    bool isMaxed = StorageUtil.getBool(AppKeys.saveSize) &&
        await windowManager.isMaximized();
    await StorageUtil.setBool(AppKeys.isMaxed, isMaxed);
    bool isPowerBoot = ref.watch(isAutoRunProvider);
    isPowerBoot ? await minimizeWindow() : await closeWindow();
  }

  @override
  Future<void> onShortcutMenuClicked(String key, String path) async {
    if (key == AppString.appName) {
      if (!ref.watch(isAppendModeProvider)) {
        ref.read(isAppendModeProvider.notifier).update();
      }
      await formatPath(ref, [path]);
      await windowManager.setSkipTaskbar(false);
      await windowManager.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uint8List? image = ref.watch(backgroundImageProvider);
    final double opacity = ref.watch(backgroundOpacityProvider);
    Color maskColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DragToResizeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (image != null) Image.memory(image, fit: BoxFit.cover),
            ColoredBox(
              color: maskColor.withValues(alpha: opacity),
              child: const Column(
                children: [
                  WindowTitleBar(),
                  Expanded(child: Row(children: [ActionView(), ContentView()])),
                  BottomView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
