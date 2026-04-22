import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/common/one_line_text.dart';

class UploadFileCard extends StatelessWidget {
  const UploadFileCard({super.key, required this.info});

  final UploadMarkInfo info;

  @override
  Widget build(BuildContext context) {
    final Color color = Color(0xFFAAAAAA);
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () => showMarkText(context, info),
      child: Container(
        constraints: BoxConstraints(maxWidth: 64),
        padding: .only(right: AppNum.spaceSmall),
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            BaseIcon(icon: Icons.edit_document, size: 16, color: color),
            OneLineText(info.name, fontSize: 12, color: color),
          ],
        ),
      ),
    );
  }
}
