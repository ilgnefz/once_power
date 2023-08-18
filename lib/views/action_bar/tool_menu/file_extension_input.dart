import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

class FileExtensionInput extends HookConsumerWidget {
  const FileExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String fileExtensionLabel = '文件扩展名';
    const String fileExtensionHint = '修改为的扩展名';
    const String fileExtensionTip = '启用修改扩展名';

    // 文件后缀名
    final fileExtController = useTextEditingController();
    final fileExtShow = useState(false);
    fileExtController.addListener(() {
      fileExtShow.value = fileExtController.text.isNotEmpty;
      ref.read(fileExtensionProvider.notifier).update(fileExtController.text);
    });

    return CommonInputMenu(
      label: fileExtensionLabel,
      controller: fileExtController,
      hintText: fileExtensionHint,
      show: fileExtShow.value,
      message: fileExtensionTip,
      icon: AppIcons.checkbox,
      selected: ref.watch(modifyExtensionProvider),
      onTap: ref.read(modifyExtensionProvider.notifier).update,
    );
  }
}
