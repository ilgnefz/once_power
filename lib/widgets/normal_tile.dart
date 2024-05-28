import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

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
    return Expanded(
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
