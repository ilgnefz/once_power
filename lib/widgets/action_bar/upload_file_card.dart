import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/widgets/base/svg_icon.dart';
import 'package:once_power/widgets/common/one_line_text.dart';

class UploadNameCard extends StatelessWidget {
  const UploadNameCard({super.key, required this.info});

  final UploadMarkInfo info;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.unselectText;
    return InkWell(
      onTap: () => showText(context, info),
      child: Container(
        width: AppNum.uploadCardW,
        padding: EdgeInsets.all(AppNum.smallG),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            // Icon(Icons.text_snippet_outlined, size: 16, color: color),
            SvgIcon(AppIcons.file, size: 16, color: color),
            OneLineText(info.name, fontSize: 12, color: color),
          ],
        ),
      ),
    );
  }
}
