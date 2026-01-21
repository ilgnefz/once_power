import 'package:flutter/material.dart';
import 'package:once_power/view/action/action.dart';
import 'package:once_power/view/bottom/bottom.dart';
import 'package:once_power/view/content/content.dart';
import 'package:once_power/view/title_bar.dart';
import 'package:window_manager/window_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DragToResizeArea(
        child: Stack(
          children: [
            // Image.file(
            //   File(AppImages.stH1),
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            // ),
            // ColoredBox(
            //   color: Colors.white.withValues(alpha: .5),
            //   child: SizedBox.expand(),
            // ),
            Column(
              children: [
                TitleBarView(),
                Flexible(child: Row(children: [ActionView(), ContentView()])),
                BottomView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
