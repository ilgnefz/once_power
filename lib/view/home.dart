import 'package:material_ui/material_ui.dart';
import 'package:once_power/view/title_bar.dart';
import 'package:once_power/view/window.dart';

import 'action/action.dart';
import 'bottom/bottom.dart';
import 'content/content.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowView(
      child: Scaffold(
        body: const Column(
          children: [
            TitleBarView(),
            Expanded(
              child: Row(
                children: [
                  ActionView(),
                  Expanded(child: ContentView()),
                ],
              ),
            ),
            BottomView(),
          ],
        ),
      ),
    );
  }
}
