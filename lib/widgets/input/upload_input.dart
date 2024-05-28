import 'dart:io';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/input/base_input.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';

class UploadInput extends ConsumerWidget {
  const UploadInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.show,
    this.onChanged,
    required this.type,
  });

  final TextEditingController controller;
  final String hintText;
  final bool show;
  final void Function(String)? onChanged;
  final FileUploadType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void uploadFile() async {
      const xType = XTypeGroup(label: '文本', extensions: ['txt']);
      final XFile? result = await openFile(acceptedTypeGroups: [xType]);
      if (result != null) {
        File file = File(result.path);
        var content = file.readAsStringSync();
        if (type == FileUploadType.prefix) {
          ref.watch(prefixControllerProvider).text = content;
        }
        if (type == FileUploadType.suffix) {
          ref.watch(suffixControllerProvider).text = content;
        }
      }
      updateName(ref);
    }

    return BaseInput(
      controller: controller,
      hintText: hintText,
      show: show,
      onChanged: onChanged,
      action: CustomTooltip(
        content: Text(
          S.of(context).uploadDesc,
          style: const TextStyle(fontSize: 13, color: Color(0xFF454545))
              .useSystemChineseFont(),
        ),
        child: ClickIcon(
          icon: Icons.upload_file_rounded,
          color: AppColors.primary,
          onTap: uploadFile,
        ),
      ),
    );
  }
}
