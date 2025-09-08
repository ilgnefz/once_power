import 'package:flutter/material.dart';
import 'package:once_power/config/theme.dart';

class EasyElevatedBtn extends StatelessWidget {
  const EasyElevatedBtn({super.key, this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontFamily: defaultFont,
          color: onPressed == null ? Colors.grey : theme.primaryColor,
        ),
      ),
    );
  }
}
