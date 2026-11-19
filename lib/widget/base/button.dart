import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/button.dart';
import 'package:once_power/constant/number.dart';

class EasyButton extends StatelessWidget {
  const EasyButton({super.key, required this.label, required this.onPressed});

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BorderRadius borderRadius = BorderRadius.circular(8.0);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Material(
          color: theme.extension<EasyButtonTheme>()?.backgroundColor,
          borderRadius: borderRadius,
          elevation: 0,
          child: child,
        );
      },
      child: InkWell(
        borderRadius: borderRadius,
        mouseCursor: SystemMouseCursors.click,
        onTap: onPressed,
        child: Container(
          height: AppNumber.widgetHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.extension<EasyButtonTheme>()?.textStyle,
          ),
        ),
      ),
    );
  }
}
