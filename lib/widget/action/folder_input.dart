import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
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
    this.cacheListKey,
    this.onUpload,
  });

  final String? cacheKey;
  final String? cacheListKey;
  final TextEditingController controller;
  final void Function(String)? onUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (cacheKey == null || cacheListKey == null) return;
        if (event is! KeyUpEvent) return;
        List<String> folders = StorageUtil.getStringList(cacheListKey!);
        if (folders.isEmpty) return;
        String currentFolder = controller.text;
        int index = folders.indexOf(currentFolder);
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          index <= 0 ? index = folders.length - 1 : index--;
          controller.text = folders[index];
          StorageUtil.setString(cacheKey!, controller.text);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          index >= folders.length - 1 || index == -1 ? index = 0 : index++;
          controller.text = folders[index];
          StorageUtil.setString(cacheKey!, controller.text);
        }
        // controller.selection = TextSelection.collapsed(
        //   offset: controller.text.length,
        // );
      },
      child: InputField(
        controller: controller,
        hintText: tr(AppL10n.organizeTarget),
        onClear: () async {
          if (cacheKey == null || cacheListKey == null) return;
          String folder = controller.text;
          List<String> folders = StorageUtil.getStringList(cacheListKey!);
          folders.remove(folder);
          await StorageUtil.setStringList(cacheListKey!, folders);
          StorageUtil.remove(cacheKey!);
        },
        action: ClickIcon(
          icon: Icons.folder_open_rounded,
          onPressed: () async {
            final String? folder = await getDirectoryPath();
            if (folder == null || folder.isEmpty) return;
            onUpload == null
                ? controller.text = folder
                : onUpload?.call(folder);
            if (cacheKey == null || cacheListKey == null) return;
            StorageUtil.setString(cacheKey!, folder);
            await saveFolder(folder, cacheListKey!);
          },
        ),
      ),
    );
  }
}

Future<void> saveFolder(String folder, String cacheListKey) async {
  List<String> folders = StorageUtil.getStringList(cacheListKey);
  if (folders.toSet().contains(folder)) return;
  folders.add(folder);
  await StorageUtil.setStringList(cacheListKey, folders);
}
