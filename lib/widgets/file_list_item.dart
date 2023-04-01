import 'package:flutter/material.dart';
import 'package:once_power/widgets/space_box.dart';

import 'my_text.dart';

class FileListItem extends StatelessWidget {
  const FileListItem({
    super.key,
    this.height,
    required this.selected,
    required this.originName,
    required this.targetName,
    required this.action,
    this.color,
    required this.onChanged,
    this.onDoubleTap,
  });

  final double? height;
  final bool selected;
  final String originName;
  final String targetName;
  final Widget action;
  final Color? color;
  final void Function(bool?)? onChanged;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onDoubleTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Checkbox(value: selected, onChanged: onChanged),
            ShowTitle(originName, color: color ?? Colors.black54),
            const SpaceBoxWidth(),
            ShowTitle(targetName),
            action,
          ],
        ),
      ),
    );
  }
}

class ShowTitle extends StatelessWidget {
  const ShowTitle(this.title, {super.key, this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyText(
        title,
        color: color ?? Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.normal,
        maxLines: 1,
      ),
    );
  }
}
