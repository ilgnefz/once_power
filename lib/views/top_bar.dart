import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:window_manager/window_manager.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        child: Consumer(
          builder: (context, ref, _) {
            bool max = ref.watch(maxWindowProvider);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo, height: 20),
                const SizedBox(width: 8),
                Text(
                  'OncePower',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ).useSystemChineseFont(),
                ),
                const Spacer(),
                ClickIcon(
                  onTap: () async {
                    await windowManager.minimize();
                  },
                  iconSize: 14,
                  color: Colors.black54,
                  svg: AppIcons.minimize,
                ),
                const SizedBox(width: 12),
                ClickIcon(
                  onTap: () async {
                    if (max) {
                      await windowManager.unmaximize();
                      ref.read(maxWindowProvider.notifier).update();
                    } else {
                      await windowManager.maximize();
                      ref.read(maxWindowProvider.notifier).update();
                    }
                  },
                  iconSize: 14,
                  color: Colors.black54,
                  svg: max ? AppIcons.unmaximize : AppIcons.maximize,
                ),
                const SizedBox(width: 12),
                ClickIcon(
                  onTap: () async {
                    await windowManager.close();
                  },
                  iconSize: 14,
                  color: Colors.black54,
                  svg: AppIcons.close,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
