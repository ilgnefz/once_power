import 'package:flutter/material.dart';
import 'package:once_power/config/global.dart';
import 'package:once_power/views/action_bar/action_bar.dart';
import 'package:once_power/views/bottom_bar/bottom_bar.dart';
import 'package:once_power/views/content_bar/content_bar.dart';
import 'package:once_power/views/top_title_bar.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
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
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: DragToResizeArea(
        child: Column(
          children: [
            TopTitleBar(),
            Expanded(child: Row(children: [ActionBar(), ContentBar()])),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
