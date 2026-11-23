import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

import 'frame.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String group = '0';

  @override
  Widget build(BuildContext context) {
    return AdvanceDialogFrame(
      // 按钮上方留白：等价于原先 3×spaceMedium（spacing + SizedBox + spacing）。
      footerSpacing: AppNumber.spaceMedium * 3,
      group: group,
      onComplete: () {},
      onCompleteExit: () => Navigator.of(context).pop(),
      onGroupChange: (value) => setState(() => group = value),
      child: AspectRatio(
        aspectRatio: 1296 / 1728,
        child: Image.file(
          File(r'D:\天翼云盘下载\AI\ewpKRA1.jpeg'),
          fit: .cover,
        ),
      ),
    );
  }
}
