import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class const ColorItem({
  super.key,
  final int? color,
  final List<Color>? colors,
  required final bool isSelected,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  this : assert(color != null || colors != null);

  /// 深色主题色行画的是派生后的浅 primary，白勾会看不清，按底色明暗取勾色。
  Color get _checkColor => color == null
      ? Colors.white
      : ThemeData.estimateBrightnessForColor(Color(color!)) == Brightness.light
      ? Colors.black
      : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color == null ? null : Color(color!),
        border: Border.all(
          color: Theme.of(context).inputDecorationTheme.outlineBorder!.color,
          width: 1.0,
        ),
        gradient: colors == null
            ? null
            : SweepGradient(colors: colors!, center: Alignment.center),
        borderRadius: .circular(AppNumber.radius),
      ),
      child: InkWell(
        onTap: onTap,
        mouseCursor: SystemMouseCursors.click,
        borderRadius: .circular(AppNumber.radius),
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(opacity: animation, child: child),
            child: isSelected
                ? Icon(Icons.check, color: _checkColor, size: 12.0)
                : null,
          ),
        ),
      ),
    );
  }
}
