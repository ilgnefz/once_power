import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/dot.dart';

class const DialogDot({
  super.key,
  required final bool selected,
  required final void Function() onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: selected ? 16 : 8,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: .circular(4),
          color: selected
              ? Theme.of(context).extension<DotTheme>()?.selectedColor
              : Theme.of(context).extension<DotTheme>()?.color,
        ),
      ),
    );
  }
}
