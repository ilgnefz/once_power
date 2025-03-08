import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/app.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

import 'action_bar/action_bar.dart';
import 'bottom_bar/bottom_bar.dart';
import 'content_bar/content_bar.dart';
import 'top_bar/top_bar.dart';

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
      removeGlobalRegedit();
      createLocalRegedit();
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

  void toggleRegedit() {
    bool useRegedit = StorageUtil.getBool(AppKeys.isUseRegedit);
    if (useRegedit) {
      removeLocalRegedit();
      createGlobalRegedit();
    }
  }

  @override
  void onWindowClose() async {
    saveOrNo();
    bool isPowerBoot = ref.watch(isAutoRunProvider);
    if (isPowerBoot) {
      await minimizeWindow();
    } else {
      await closeWindow();
    }
  }

  @override
  Future<void> onShortcutMenuClicked(String key, String path) async {
    if (key == AppText.name) {
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
    return const Scaffold(
      backgroundColor: Colors.white,
      body: DragToResizeArea(
        child: Column(
          children: [
            TopBar(),
            Expanded(child: Row(children: [ActionBar(), ContentBar()])),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
