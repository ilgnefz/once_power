import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/base_input.dart';

class TargetFolderInput extends ConsumerWidget {
  const TargetFolderInput({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String targetFolder = S.of(context).targetFolder;
    TextEditingController controller = ref.watch(targetControllerProvider);

    void onChanged(String folder) {
      controller.text = folder;
    }

    void onKeyEvent(event) {
      if (event is! KeyUpEvent) return;
      if (!ref.watch(saveConfigProvider)) return;
      String currentFolder = controller.text;
      List<String> list = StorageUtil.getStringList(AppKeys.targetFolderList);
      int index = list.indexOf(currentFolder);
      if (index == -1 && currentFolder != '') {
        list.add(currentFolder);
        StorageUtil.setStringList(AppKeys.targetFolderList, list);
        return;
      }
      if (list.isEmpty) return;
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (currentFolder == '') index = 0;
        if (index == 0) {
          controller.text = list[list.length - 1];
        } else {
          controller.text = list[index - 1];
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (currentFolder == '') index == list.length - 1;
        if (index == list.length - 1) {
          controller.text = list[0];
        } else {
          controller.text = list[index + 1];
        }
      }
      StorageUtil.setString(AppKeys.targetFolder, controller.text);
    }

    return BaseInput(
      hintText: targetFolder,
      // readOnly: true,
      controller: controller,
      onChanged: onChanged,
      onKeyEvent: onKeyEvent,
      show: ref.watch(targetClearProvider),
    );
  }
}
