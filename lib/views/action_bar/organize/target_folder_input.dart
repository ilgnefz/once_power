import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class TargetFolderInput extends ConsumerWidget {
  const TargetFolderInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = ref.watch(folderControllerProvider);

    void onChanged(String folder) {
      controller.text = folder;
    }

    void onKeyEvent(event) {
      if (event is! KeyUpEvent) return;
      if (!ref.watch(isSaveConfigProvider)) return;
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

    Future<void> selectTargetFolder() async {
      final String? folder = await getDirectoryPath();
      if (folder != null) {
        controller.text = folder;
        if (ref.watch(isSaveConfigProvider)) {
          targetFolderCache(ref, folder);
        }
      }
    }

    void onClear() async {
      String? folder = controller.text;
      List<String> list = StorageUtil.getStringList(AppKeys.targetFolderList);
      if (list.contains(folder)) list.remove(folder);
      await StorageUtil.setStringList(AppKeys.targetFolderList, list);
      await StorageUtil.remove(AppKeys.targetFolder);
      ref.read(folderControllerProvider.notifier).clear();
    }

    return Padding(
      padding: EdgeInsets.only(left: AppNum.largeG, right: AppNum.mediumG),
      child: BaseInput(
        enable: !ref.watch(useRuleOrganizeProvider) &&
            !ref.watch(useTopParentsProvider),
        hintText: S.of(context).targetFolder,
        controller: controller,
        padding: EdgeInsets.only(left: AppNum.inputP, right: AppNum.smallG),
        showClear: ref.watch(folderClearProvider),
        onClear: onClear,
        onChanged: onChanged,
        onKeyEvent: onKeyEvent,
        trailing: TooltipIcon(
          tip: S.of(context).targetFolder,
          icon: Icons.folder_open_rounded,
          onTap: selectTargetFolder,
        ),
      ),
    );
  }
}
