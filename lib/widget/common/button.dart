import 'package:flutter/material.dart';
import 'package:once_power/config/theme/button.dart';
import 'package:once_power/const/num.dart';

class EasyButton extends StatelessWidget {
  const EasyButton({super.key, required this.label, required this.onPressed});

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BorderRadius borderRadius = BorderRadius.circular(8.0);
    return Material(
      color: theme.extension<CustomButtonTheme>()?.backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        mouseCursor: SystemMouseCursors.click,
        onTap: onPressed,
        child: Container(
          height: AppNum.widgetHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.extension<CustomButtonTheme>()?.textStyle,
          ),
        ),
      ),
    );
  }
}
