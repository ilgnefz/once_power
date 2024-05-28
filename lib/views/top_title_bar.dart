import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:window_manager/window_manager.dart';

class TopTitleBar extends ConsumerWidget {
  const TopTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String appName = 'OncePower';
    const Color color = Colors.black54;

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

    return DragToMoveArea(
      child: Container(
        height: AppNum.topTitleBarH,
        padding: const EdgeInsets.symmetric(horizontal: AppNum.topTitleBarP),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, height: AppNum.logoH),
            const SizedBox(width: AppNum.logoInterval),
            Text(appName, style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            ClickIcon(
              onTap: minimize,
              iconSize: AppNum.topTitleBarIconSize,
              color: color,
              svg: AppIcons.minimize,
            ),
            const SizedBox(width: AppNum.topTitleBarIconInterval),
            ClickIcon(
              onTap: maximize,
              iconSize: AppNum.topTitleBarIconSize,
              color: color,
              svg: isMax ? AppIcons.unmaximize : AppIcons.maximize,
            ),
            const SizedBox(width: AppNum.topTitleBarIconInterval),
            ClickIcon(
              onTap: close,
              iconSize: AppNum.topTitleBarIconSize,
              color: color,
              svg: AppIcons.close,
            ),
          ],
        ),
      ),
    );
  }
}
