import 'package:flutter/material.dart';
import 'package:once_power/constants/colors.dart';

class EasyElevatedBtn extends StatelessWidget {
  const EasyElevatedBtn({super.key, this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: onPressed == null
              ? AppColors.btnTextDisabled
              : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
