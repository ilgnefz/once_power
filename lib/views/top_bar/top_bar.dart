import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/top_bar/drag_area.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:window_manager/window_manager.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color color = Colors.black54;
    const double iconS = AppNum.iconSmallS;
    const double iconG = AppNum.largeG;

    bool isMax = ref.watch(maxWindowProvider);

    void minimize() async {
      await windowManager.minimize();
    }

    void maximize() async {
      if (isMax) {
        await windowManager.unmaximize();
      } else {
        await windowManager.maximize();
      }
      ref.read(maxWindowProvider.notifier).update();
    }

    void close() async {
      await windowManager.close();
    }

    return DragArea(
      onDoubleTap: maximize,
      child: Container(
        height: AppNum.topBarH,
        padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, height: AppNum.logoS),
            const SizedBox(width: AppNum.mediumG),
            Text(AppText.name, style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            ClickIcon(
              onTap: minimize,
              iconSize: iconS,
              color: color,
              svg: AppIcons.minimize,
            ),
            const SizedBox(width: iconG),
            ClickIcon(
              onTap: maximize,
              iconSize: iconS,
              color: color,
              svg: isMax ? AppIcons.unmaximize : AppIcons.maximize,
            ),
            const SizedBox(width: iconG),
            ClickIcon(
              onTap: close,
              iconSize: iconS,
              color: color,
              svg: AppIcons.close,
            ),
          ],
        ),
      ),
    );
  }
}
