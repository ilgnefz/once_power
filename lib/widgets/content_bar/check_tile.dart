import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class CheckTile extends StatelessWidget {
  const CheckTile({
    super.key,
    required this.check,
    required this.label,
    required this.onChanged,
    this.color,
    this.fontSize = 13,
    this.action,
  });

  final bool check;
  final String label;
  final void Function(bool?)? onChanged;
  final Color? color;
  final double? fontSize;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: AppNum.fileCardH,
        padding: const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        child: Row(
          children: [
            Checkbox(value: check, onChanged: onChanged),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: color, fontSize: fontSize)
                    .useSystemChineseFont(),
              ),
            ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
