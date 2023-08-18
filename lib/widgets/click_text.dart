import 'package:flutter/material.dart';
import 'package:once_power/constants/colors.dart';

class ClickText extends StatelessWidget {
  const ClickText(this.label, {super.key, required this.onTap});

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 32,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: Text(label, style: const TextStyle(color: AppColors.select)),
          ),
        ),
      ),
    );
  }
}
