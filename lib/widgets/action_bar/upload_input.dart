import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/base_input.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/easy_tooltip.dart';

class UploadInput extends StatelessWidget {
  const UploadInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.show,
  });

  final TextEditingController controller;
  final String hintText;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: controller,
      hintText: hintText,
      show: show,
      action: EasyTooltip(
        message: '上传 .txt 文件',
        child: ClickIcon(
          icon: Icons.upload_file_rounded,
          color: AppColors.select,
          onTap: () {},
        ),
      ),
    );
  }
}
