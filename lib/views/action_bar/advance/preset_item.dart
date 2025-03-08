import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/one_line_text.dart';

class PresetItem extends StatelessWidget {
  const PresetItem(
    this.label, {
    super.key,
    required this.onTap,
    required this.onRemove,
  });

  final String label;
  final void Function() onTap;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: AppNum.presetMenuItemH,
          width: AppNum.presetMenuW,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OneLineText(label, fontSize: 13),
              ClickIcon(
                size: 16,
                iconSize: 14,
                icon: Icons.close_rounded,
                color: Colors.grey[400],
                onTap: onRemove,
              )
            ],
          ),
        ),
      ),
    );
  }
}
