import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/widgets/action_bar/operate_item.dart';
import 'package:once_power/widgets/action_bar/upload_file_card.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class UploadInput extends ConsumerWidget {
  const UploadInput({
    super.key,
    required this.label,
    required this.tip,
    required this.selected,
    required this.onToggle,
    required this.hintText,
    required this.controller,
    required this.showClear,
    required this.info,
    required this.onUpload,
    required this.onClear,
  });

  final String label;
  final String tip;
  final bool selected;
  final void Function() onToggle;
  final String hintText;
  final TextEditingController controller;
  final bool showClear;
  final UploadMarkInfo? info;
  final void Function(File file) onUpload;
  final void Function() onClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void uploadFile() async {
      final xType =
          XTypeGroup(label: S.of(context).text, extensions: const ['txt']);
      final XFile? result = await openFile(acceptedTypeGroups: [xType]);
      if (result != null) {
        File file = File(result.path);
        onUpload(file);
      }
    }

    return OperateItem(
      label: label,
      icon: AppIcons.cycle,
      tip: tip,
      selected: selected,
      onToggle: onToggle,
      child: BaseInput(
        hintText: hintText,
        controller: controller,
        showClear: showClear || info != null,
        onClear: () {
          onClear();
          updateName(ref);
        },
        onChanged: (value) => updateName(ref),
        trailing: TooltipIcon(
          tip: S.of(context).uploadDesc,
          placement: Placement.right,
          icon: Icons.upload_file_rounded,
          color: AppColors.unselectIcon,
          onTap: uploadFile,
        ),
        leading: info != null ? UploadNameCard(info: info!) : null,
      ),
    );
  }
}
