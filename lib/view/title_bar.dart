import 'package:flutter/material.dart';
import 'package:once_power/config/theme/title_bar.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/images.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:window_manager/window_manager.dart';

class TitleBarView extends StatefulWidget {
  const TitleBarView({super.key});

  @override
  State<TitleBarView> createState() => _TitleBarViewState();
}

class _TitleBarViewState extends State<TitleBarView> {
  final double size = AppNum.titleBarIcon;
  bool isMax = false;
  late TitleBarTheme? theme;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      isMax = await windowManager.isMaximized();
      setState(() {});
    });
  }

  void minimize() async => await windowManager.minimize();

  void maximizeOrUnmaximize() async {
    isMax ? await windowManager.unmaximize() : await windowManager.maximize();
    isMax = !isMax;
    setState(() {});
  }

  void close() async => await windowManager.close();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<TitleBarTheme>();
    final Color? color = theme?.iconColor;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) => windowManager.startDragging(),
      onDoubleTap: maximizeOrUnmaximize,
      child: Container(
        width: double.infinity,
        height: AppNum.titleBar,
        padding: .only(left: AppNum.padding),
        child: Row(
          children: [
            Image.asset(AppImages.logo, height: AppNum.logoSize),
            const SizedBox(width: 8),
            Text(AppText.appName, style: theme?.textStyle),
            const Spacer(),
            TitleBarIcon(
              svg: AppIcons.minimize,
              color: color,
              onPressed: minimize,
            ),
            TitleBarIcon(
              svg: isMax ? AppIcons.unmaximize : AppIcons.maximize,
              color: color,
              onPressed: maximizeOrUnmaximize,
            ),
            TitleBarIcon(svg: AppIcons.close, color: color, onPressed: close),
          ],
        ),
      ),
    );
  }
}

class TitleBarIcon extends StatelessWidget {
  const TitleBarIcon({
    super.key,
    required this.svg,
    required this.color,
    required this.onPressed,
  });

  final String svg;
  final Color? color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: onPressed,
      child: Container(
        width: 48,
        alignment: Alignment.center,
        child: BaseIcon(svg: svg, size: AppNum.titleBarIcon, color: color),
      ),
    );
  }
}
