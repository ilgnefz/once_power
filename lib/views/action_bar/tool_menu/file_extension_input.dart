import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

class FileExtensionInput extends ConsumerWidget {
  const FileExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool disable = !ref.read(modifyExtensionProvider);
    const String fileExtensionLabel = '文件扩展名';
    final String fileExtensionHint = disable ? '输入已禁用' : '修改为的扩展名';
    const String fileExtensionTip = '启用修改扩展名';

    return CommonInputMenu(
      disable: disable,
      label: fileExtensionLabel,
      controller: ref.watch(extensionControllerProvider),
      hintText: fileExtensionHint,
      show: ref.watch(extensionClearProvider),
      message: fileExtensionTip,
      icon: AppIcons.checkbox,
      selected: ref.watch(modifyExtensionProvider),
      onChanged: (v) => updateExtension(ref),
      onTap: () {
        ref.read(modifyExtensionProvider.notifier).update();
        ref.read(extensionControllerProvider).clear();
        updateExtension(ref);
      },
    );
  }
}
