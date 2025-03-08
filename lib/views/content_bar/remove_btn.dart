import 'package:flutter/material.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class RemoveBtn extends StatelessWidget {
  const RemoveBtn({super.key, required this.onTap, this.color});

  final Color? color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.symmetric(horizontal: AppNum.mediumG),
      padding: EdgeInsets.only(right: 4),
      child: ClickIcon(
        size: 32,
        iconSize: AppNum.defaultIconS,
        icon: Icons.delete_rounded,
        color: color ?? AppColors.icon,
        onTap: onTap,
      ),
    );
  }
}
