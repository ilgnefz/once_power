import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/common/one_line_text.dart';

class NormalTile extends StatelessWidget {
  const NormalTile({
    super.key,
    required this.label,
    this.padding,
    this.fontSize,
  });

  final String label;
  final EdgeInsets? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return OneLineText(
      label,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
      style: TextStyle(fontSize: fontSize).useSystemChineseFont(),
    );
  }
}
