import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

class EasyTextBtn extends StatelessWidget {
  const EasyTextBtn(
    this.label, {
    super.key,
    this.fontSize = 13,
    required this.onTap,
  });

  final String label;
  final double? fontSize;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppNum.presetMenuItemH,
          width: AppNum.presetMenuW,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: Theme.of(context).primaryColor,
            ).useSystemChineseFont(),
          ),
        ),
      ),
    );
  }
}
