import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/input/input.dart';

class FileExtensionInput extends ConsumerWidget {
  const FileExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool disable = !ref.read(modifyExtensionProvider);
    const String fileExtensionLabel = '文件扩展名';
    final String fileExtensionHint = disable ? '输入已禁用' : '修改为的扩展名';
    const String fileExtensionTip = '启用修改扩展名';

    void clearInput() {
      ref.read(modifyExtensionProvider.notifier).update();
      ref.read(extensionControllerProvider).clear();
      updateExtension(ref);
    }

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
      onTap: clearInput,
    );
  }
}
