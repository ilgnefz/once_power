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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      mouseCursor: SystemMouseCursors.click,
      borderRadius: .circular(AppNumber.radiusSmall),
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: color == null ? null : Color(color!),
          gradient: colors == null
              ? null
              : SweepGradient(colors: colors!, center: Alignment.center),
          borderRadius: .circular(AppNumber.radius),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(opacity: animation, child: child),
          child: isSelected
              ? Icon(Icons.check, color: Colors.white, size: 12.0)
              : null,
        ),
      ),
    );
  }
}
