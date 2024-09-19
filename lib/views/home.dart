import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/config/global.dart';
import 'package:window_manager/window_manager.dart';

import 'action_bar/action_bar.dart';
import 'bottom_bar/bottom_bar.dart';
import 'content_bar/content_bar.dart';
import 'top_bar/top_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    saveOrNo();
    await windowManager.destroy();
    exit(0);
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
