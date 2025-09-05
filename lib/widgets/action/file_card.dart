import 'package:flutter/material.dart';
import 'package:once_power/config/theme/btn.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/widgets/base/one_line_text.dart';
import 'package:once_power/widgets/base/svg_icon.dart';

class UploadFileCard extends StatelessWidget {
  const UploadFileCard({super.key, required this.info});

  final UploadMarkInfo info;

  @override
  Widget build(BuildContext context) {
    final Color color = Color(0xFFAAAAAA);
    return InkWell(
      onTap: () => showText(context, info),
      child: Container(
        width: AppNum.fileCard,
        padding: EdgeInsets.all(AppNum.spaceSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).extension<BtnTheme>()?.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            SvgIcon(AppIcons.file, size: 16, color: color),
            OneLineText(info.name, fontSize: 12, color: color),
          ],
        ),
      ),
    );
  }
}
