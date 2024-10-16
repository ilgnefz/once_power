import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/global.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/regedit.dart';
import 'package:once_power/utils/storage.dart';
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

  @override
  void onWindowClose() async {
    saveOrNo();
    bool useRegedit = StorageUtil.getBool(AppKeys.isUseRegedit) ?? false;
    if (useRegedit) {
      createGlobalRegedit();
      removeLocalRegedit();
    }
    await windowManager.destroy();
    exit(0);
  }

  @override
  Future<void> onShortcutMenuClicked(String key, String path) async {
    if (key == AppText.name) await formatPath(ref, [path]);
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
