import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/action_bar/organize_menu/target_folder_input.dart';
import 'package:once_power/widgets/custom_text_button.dart';
import 'package:once_power/widgets/custom_checkbox.dart';

import 'organize_button.dart';
import 'delete_folder_button.dart';
import 'description_text.dart';

class OrganizeMenu extends ConsumerWidget {
  const OrganizeMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String saveLog = S.of(context).saveLog;
    final String selectFolderLabel = S.of(context).selectTargetFolder;
    final String appendMode = S.of(context).appendMode;
    final String addFileLabel = S.of(context).addFile;
    final String addFolderLabel = S.of(context).addFolder;

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
      if (files.isNotEmpty) formatXFile(ref, files);
    }

    void addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) {
        if (!append) ref.read(fileListProvider.notifier).clear();
        ref.read(totalProvider.notifier).update(folders.length);
        for (var folder in folders) {
          formatFile(ref, folder!);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: DescriptionText()),
        const SizedBox(height: AppNum.gapH),
        const TargetFolderInput(),
        const SizedBox(height: AppNum.gapH),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCheckbox(
              saveLog,
              checked: ref.watch(saveLogProvider),
              onChanged: (v) => ref.read(saveLogProvider.notifier).update(),
            ),
            CustomTextButton(selectFolderLabel, onTap: selectTargetFolder),
          ],
        ),
        const SizedBox(height: AppNum.gapH),
        Row(
          children: [
            CustomCheckbox(
              appendMode,
              checked: ref.watch(appendModeProvider),
              onChanged: (v) => ref.read(appendModeProvider.notifier).update(),
            ),
            const Spacer(),
            CustomTextButton(addFileLabel, onTap: addFile),
            const SizedBox(width: AppNum.gapW),
            CustomTextButton(addFolderLabel, onTap: addFolder),
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
