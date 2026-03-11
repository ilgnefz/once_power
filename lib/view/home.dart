import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/core/file.dart';
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

class _HomeViewState extends ConsumerState<HomeView> with ShortcutMenuListener {
  final List<FileSystemEntity> _entities = [];

  @override
  void initState() {
    shortcutMenuExtender.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    shortcutMenuExtender.removeListener(this);
    super.dispose();
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DragToResizeArea(
        child: Stack(
          children: [
            // ImageFiltered(
            //   imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            //   child: Image.file(
            //     File(AppImages.bg),
            //     fit: BoxFit.cover,
            //     width: double.infinity,
            //   ),
            // ),
            // ColoredBox(
            //   color: Colors.white.withValues(alpha: .5),
            //   child: SizedBox.expand(),
            // ),
            Column(
              children: [
                RepaintBoundary(child: TitleBarView()),
                Flexible(
                  child: Row(
                    children: [
                      RepaintBoundary(child: ActionView()),
                      buildContent(),
                    ],
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
