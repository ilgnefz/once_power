import 'package:flutter/material.dart';
import 'package:once_power/widget/base/text.dart';

class EasyElevatedButton extends StatelessWidget {
  const EasyElevatedButton({super.key, this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: theme.elevatedButtonTheme.style,
      child: BaseText(label, color: theme.primaryColor),
    );
  }
}
