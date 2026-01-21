import 'package:flutter/material.dart';
import 'package:once_power/config/theme/title_bar.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/images.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/widget/common/click_icon.dart';
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
    TitleBarTheme? theme = Theme.of(context).extension<TitleBarTheme>();
    Color? color = theme?.iconColor;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) => windowManager.startDragging(),
      onDoubleTap: maximizeOrUnmaximize,
      child: Container(
        width: double.infinity,
        height: AppNum.titleBar,
        padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
        child: Row(
          spacing: 8,
          children: [
            Image.asset(AppImages.logo, height: AppNum.logoSize),
            Text(AppText.appName, style: theme?.textStyle),
            const Spacer(),
            ClickIcon(
              svg: AppIcons.minimize,
              iconSize: size,
              color: color,
              onPressed: minimize,
            ),
            ClickIcon(
              svg: isMax ? AppIcons.unmaximize : AppIcons.maximize,
              iconSize: size,
              color: color,
              onPressed: maximizeOrUnmaximize,
            ),
            ClickIcon(
              svg: AppIcons.close,
              iconSize: size,
              color: color,
              onPressed: close,
            ),
          ],
        ),
      ),
    );
  }
}
