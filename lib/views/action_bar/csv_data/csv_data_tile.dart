import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class CsvDataTile extends StatelessWidget {
  const CsvDataTile({
    super.key,
    this.height,
    this.minHeight,
    required this.color,
    required this.list,
    this.textStyle,
    this.onTap,
    this.onDoubleTap,
  });

  final double? height;
  final double? minHeight;
  final Color color;
  final List<String> list;
  final TextStyle? textStyle;
  final void Function(int)? onTap;
  final void Function(int)? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Row(
        children: List.generate(
          list.length,
          (index) => Flexible(
            child: InkWell(
              onTap: onTap == null ? null : () => onTap!(index),
              onDoubleTap:
                  onDoubleTap == null ? null : () => onDoubleTap!(index),
              child: Container(
                height: height,
                constraints: minHeight == null
                    ? null
                    : BoxConstraints(minHeight: minHeight!),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  list[index],
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      const TextStyle(fontSize: 13).useSystemChineseFont(),
                ),
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
