import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/input_field.dart';

class FolderInput extends ConsumerWidget {
  const FolderInput({
    super.key,
    required this.controller,
    this.cacheKey,
    this.onChanged,
    this.onUpload,
  });

  final String? cacheKey;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InputField(
      controller: controller,
      hintText: tr(AppL10n.organizeTarget),
      onChanged: onChanged,
      onClear: () {
        if (cacheKey != null) StorageUtil.remove(cacheKey!);
      },
      action: ClickIcon(
        icon: Icons.folder_open_rounded,
        onPressed: () async {
          final String? folder = await getDirectoryPath();
          if (folder == null || folder.isEmpty) return;
          onUpload == null ? controller.text = folder : onUpload?.call(folder);
          onChanged?.call(folder);
          if (cacheKey != null) StorageUtil.setString(cacheKey!, folder);
        },
      ),
    );
  }
}
