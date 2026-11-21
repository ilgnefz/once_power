import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/title_bar.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/constant/text.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:window_manager/window_manager.dart';

class TitleBarView extends StatefulWidget {
  const TitleBarView({super.key});

  @override
  State<TitleBarView> createState() => _TitleBarViewState();
}

class _TitleBarViewState extends State<TitleBarView> {
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
    final ThemeData theme = Theme.of(context);
    final TitleBarTheme? titleBarTheme = theme.extension<TitleBarTheme>();
    final Color? color = titleBarTheme?.iconColor;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) => windowManager.startDragging(),
      onDoubleTap: maximizeOrUnmaximize,
      child: Container(
        width: double.infinity,
        height: AppNumber.titleBarHeight,
        padding: .only(left: AppNumber.paddingMedium),
        child: Row(
          children: [
            Stack(
              fit: .loose,
              children: [
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(width: 14, height: 14, color: Colors.white),
                ),
                BaseIcon(
                  svg: AppIcons.logo,
                  size: AppNumber.logo,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
            SizedBox(width: AppNumber.spaceSmall),
            Text(AppText.appName, style: titleBarTheme?.textStyle),
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
        width: AppNumber.titleBarIconWidth,
        alignment: Alignment.center,
        child: BaseIcon(svg: svg, size: AppNumber.titleBarIcon, color: color),
      ),
    );
  }
}
