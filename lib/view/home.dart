import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/setting.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/registry.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/view/action/action.dart';
import 'package:once_power/view/bottom/bottom.dart';
import 'package:once_power/view/content/content.dart';
import 'package:once_power/view/title_bar.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:window_manager/window_manager.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WindowListener, ShortcutMenuListener {
  final List<FileSystemEntity> _entities = [];

  void _init() async {
    await windowManager.setPreventClose(true);
    if (StorageUtil.getBool(AppKeys.isUseRegedit)) {
      AppRegistry.removeClosed();
      AppRegistry.addRunning();
    }
  }

  Future<void> minimizeWindow() async {
    await windowManager.setSkipTaskbar(true);
    await windowManager.hide();
  }

  Future<void> closeWindow() async {
    toggleRegedit();
    await windowManager.close();
    // await windowManager.destroy();
    // exit(0);
  }

  void toggleRegedit() {
    if (StorageUtil.getBool(AppKeys.isUseRegedit)) {
      AppRegistry.removeRunning();
      AppRegistry.addClosed();
    }
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
  void onWindowResized() async {
    if (StorageUtil.getBool(AppKeys.saveSize)) {
      Size size = await windowManager.getSize();
      await StorageUtil.setDouble(AppKeys.windowWidth, size.width);
      await StorageUtil.setDouble(AppKeys.windowHeight, size.height);
    }
  }

  @override
  void onWindowMoved() async {
    if (StorageUtil.getBool(AppKeys.savePosition)) {
      Offset position = await windowManager.getPosition();
      await StorageUtil.setDouble(AppKeys.windowX, position.dx);
      await StorageUtil.setDouble(AppKeys.windowY, position.dy);
    }
  }

  @override
  void onWindowClose() async {
    bool isMaxed =
        StorageUtil.getBool(AppKeys.saveSize) &&
        await windowManager.isMaximized();
    await StorageUtil.setBool(AppKeys.isMaxed, isMaxed);
    bool isPowerBoot = ref.watch(isAutoRunProvider);
    isPowerBoot ? await minimizeWindow() : await closeWindow();
  }

  @override
  Future<void> onShortcutMenuClicked(String key, String path) async {
    if (key == AppText.appName) {
      await formatPath(ref, [path]);
      setState(() {});
    }
  }

  Widget buildContent() => _entities.isEmpty
      ? ContentView()
      : ListView.builder(
          itemCount: _entities.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(_entities[index].path));
          },
        );

  @override
  Widget build(BuildContext context) {
    Uint8List? background = ref.watch(
      themeSettingProvider.select((e) => e.backgroundBytes),
    );
    double sigma = ref.watch(themeSettingProvider.select((e) => e.sigma));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DragToResizeArea(
        child: Stack(
          children: [
            if (background != null) ...[
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Image.memory(
                  background,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(
                  alpha: ref.watch(themeSettingProvider.select((e) => e.alpha)),
                ),
                child: SizedBox.expand(),
              ),
            ],
            Column(
              children: [
                RepaintBoundary(child: TitleBarView()),
                Flexible(
                  child: AbsorbPointer(
                    absorbing: ref.watch(isApplyingProvider),
                    child: Row(
                      children: [
                        RepaintBoundary(child: ActionView()),
                        buildContent(),
                      ],
                    ),
                  ),
                ),
                BottomView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
