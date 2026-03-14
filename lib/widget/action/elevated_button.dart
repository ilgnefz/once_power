import 'package:flutter/material.dart';

class EasyElevatedButton extends StatelessWidget {
  const EasyElevatedButton({super.key, this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(padding: .all(.symmetric(horizontal: 23))),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: onPressed == null ? Colors.grey : theme.primaryColor,
        ),
      ),
    );
  }
}
