import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/file.dart';
import 'package:once_power/views/action_bar/organize_menu/delete_folder_button.dart';
import 'package:once_power/views/action_bar/organize_menu/description_text.dart';
import 'package:once_power/views/action_bar/organize_menu/organize_button.dart';
import 'package:once_power/widgets/base_input.dart';
import 'package:once_power/widgets/click_text.dart';
import 'package:once_power/widgets/easy_checkbox.dart';

class OrganizeMenu extends ConsumerWidget {
  const OrganizeMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool append = ref.watch(appendModeProvider);
    TextEditingController controller = ref.watch(targetControllerProvider);

    void selectTargetFolder() async {
      final String? folder = await getDirectoryPath();
      if (folder != null) controller.text = folder;
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
          hintText: '目标文件夹',
          readOnly: true,
          controller: controller,
          show: ref.watch(targetClearProvider),
        ),
        const SizedBox(height: AppNum.gapH),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EasyCheckbox(
              '保存日志',
              checked: ref.watch(saveLogProvider),
              onChanged: (v) => ref.read(saveLogProvider.notifier).update(),
            ),
            ClickText('选择目标文件夹', onTap: selectTargetFolder),
          ],
        ),
        const SizedBox(height: AppNum.gapH),
        Row(
          children: [
            EasyCheckbox(
              '追加模式',
              checked: ref.watch(appendModeProvider),
              onChanged: (v) => ref.read(appendModeProvider.notifier).update(),
            ),
            const Spacer(),
            ClickText('添加文件', onTap: addFile),
            const SizedBox(height: AppNum.gapW),
            ClickText('添加文件夹', onTap: addFolder),
          ],
        ),
        const SizedBox(height: AppNum.gapH),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [DeleteFolderButton(), OrganizeButton()],
        ),
      ],
    );
  }
}
