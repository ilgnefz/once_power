import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/custom.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/images.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:window_manager/window_manager.dart';

class WindowTitleBar extends ConsumerWidget {
  const WindowTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TitleBarTheme? theme = Theme.of(context).extension<TitleBarTheme>();
    Color? color = theme?.iconColor;
    const double iconSize = AppNum.iconSmall;
    const double iconSpace = AppNum.spaceLarge;

    bool isMax = ref.watch(isMaxProvider);

    void minimize() async => await windowManager.minimize();

    void maximize() async {
      if (isMax) {
        await windowManager.unmaximize();
      } else {
        await windowManager.maximize();
      }
      ref.read(isMaxProvider.notifier).update();
    }

    void close() async => await windowManager.close();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      onDoubleTap: maximize,
      child: Container(
        height: AppNum.top,
        padding: const EdgeInsets.symmetric(horizontal: AppNum.padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, height: AppNum.logo),
            const SizedBox(width: AppNum.spaceMedium),
            Text(AppString.appName, style: theme?.textStyle),
            const Spacer(),
            ClickIcon(
              onPressed: minimize,
              iconSize: iconSize,
              color: color,
              svg: AppIcons.minimize,
            ),
            const SizedBox(width: iconSpace),
            ClickIcon(
              onPressed: maximize,
              iconSize: iconSize,
              color: color,
              svg: isMax ? AppIcons.unmaximize : AppIcons.maximize,
            ),
            const SizedBox(width: iconSpace),
            ClickIcon(
              onPressed: close,
              iconSize: iconSize,
              color: color,
              svg: AppIcons.close,
            ),
          ],
        ),
      ),
    );
  }
}
