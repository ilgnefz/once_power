import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/file.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/click_text.dart';
import 'package:once_power/widgets/easy_checkbox.dart';
import 'package:once_power/widgets/input/base_input.dart';

import 'arrange_button.dart';
import 'delete_folder_button.dart';
import 'description_text.dart';

class ArrangeMenu extends ConsumerWidget {
  const ArrangeMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String targetFolder = '目标文件夹';
    const String saveLog = '保存日志';
    const String selectFolder = '选择目标文件夹';
    const String appendMode = '追加模式';
    const String addFileText = '添加文件';
    const String addFolderText = '添加文件夹';

    bool append = ref.watch(appendModeProvider);
    TextEditingController controller = ref.watch(targetControllerProvider);

    void selectTargetFolder() async {
      final String? folder = await getDirectoryPath();
      if (folder != null) {
        controller.text = folder;
        if (ref.watch(saveConfigProvider)) {
          StorageUtil.setString(AppKeys.targetFolder, folder);
        }
      }
    }

    void addFile() async {
      final List<XFile> files = await openFiles();
      if (!append) ref.read(fileListProvider.notifier).clear();
      if (files.isNotEmpty) xFileFormat(ref, files);
    }

    void addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) {
        if (!append) ref.read(fileListProvider.notifier).clear();
        for (var folder in folders) {
          fileFormat(ref, folder!);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: DescriptionText()),
        const SizedBox(height: AppNum.gapH),
        BaseInput(
          hintText: targetFolder,
          readOnly: true,
          controller: controller,
          show: ref.watch(targetClearProvider),
        ),
        const SizedBox(height: AppNum.gapH),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EasyCheckbox(
              saveLog,
              checked: ref.watch(saveLogProvider),
              onChanged: (v) => ref.read(saveLogProvider.notifier).update(),
            ),
            ClickText(selectFolder, onTap: selectTargetFolder),
          ],
        ),
        const SizedBox(height: AppNum.gapH),
        Row(
          children: [
            EasyCheckbox(
              appendMode,
              checked: ref.watch(appendModeProvider),
              onChanged: (v) => ref.read(appendModeProvider.notifier).update(),
            ),
            const Spacer(),
            ClickText(addFileText, onTap: addFile),
            const SizedBox(height: AppNum.gapW),
            ClickText(addFolderText, onTap: addFolder),
          ],
        ),
        const SizedBox(height: AppNum.gapH),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [DeleteFolderButton(), ArrangeButton()],
        ),
      ],
    );
  }
}
