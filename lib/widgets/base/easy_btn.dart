import 'package:flutter/material.dart';
import 'package:once_power/config/theme/btn.dart';
import 'package:once_power/constants/num.dart';

class EasyBtn extends StatelessWidget {
  const EasyBtn({super.key, required this.label, required this.onPressed});

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BorderRadius borderRadius = BorderRadius.circular(8.0);
    return Material(
      color: theme.extension<BtnTheme>()?.backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        child: Container(
          height: AppNum.input,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.center,
          child: Text(label, style: theme.extension<BtnTheme>()?.textStyle),
        ),
      ),
    );
  }
}
