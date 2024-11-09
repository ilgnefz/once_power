import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/action_bar/organize/delete_selected_button.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/custom_tooltip.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';
import 'package:once_power/widgets/common/easy_text_btn.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

import 'organize_button.dart';
import 'delete_folder_button.dart';
import 'description_text.dart';
import 'target_folder_input.dart';

class OrganizeAction extends ConsumerWidget {
  const OrganizeAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String classifiedFileLabel = S.of(context).classifiedFile;
    final String selectFolderLabel = S.of(context).selectTargetFolder;
    final String appendModeLabel = S.of(context).appendMode;
    final String addFileLabel = S.of(context).addFile;
    final String addFolderLabel = S.of(context).addFolder;

    const double gap = AppNum.mediumG;

    TextEditingController controller = ref.watch(targetControllerProvider);

    Future<void> selectTargetFolder() async {
      final String? folder = await getDirectoryPath();
      if (folder != null) {
        controller.text = folder;
        if (ref.watch(saveConfigProvider)) {
          targetFolderCache(ref, folder);
        }
      }
    }

    Future<void> addFile() async {
      final List<XFile> files = await openFiles();
      if (files.isNotEmpty) await formatXFile(ref, files);
    }

    Future<void> addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) await formatFolder(ref, folders);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SingleChildScrollView(child: DescriptionText())),
        const SizedBox(height: gap),
        const TargetFolderInput(),
        const SizedBox(height: gap),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EasyCheckbox(
              classifiedFileLabel,
              checked: ref.watch(classifiedFileProvider),
              onChanged: (v) =>
                  ref.read(classifiedFileProvider.notifier).update(),
            ),
            const SizedBox(width: AppNum.mediumG),
            EasyTooltip(
              message: S.of(context).useTimeClassification,
              textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
                  .useSystemChineseFont(),
              placement: Placement.right,
              child: ClickIcon(
                size: 20,
                svg: AppIcons.date,
                color: ref.watch(useTimeClassificationProvider)
                    ? Theme.of(context).primaryColor
                    : AppColors.unselectIcon,
                onTap: ref.read(useTimeClassificationProvider.notifier).update,
              ),
            ),
            const Spacer(),
            EasyTextBtn(selectFolderLabel, onTap: selectTargetFolder),
          ],
        ),
        const SizedBox(height: gap),
        Row(
          children: [
            EasyCheckbox(
              appendModeLabel,
              checked: ref.watch(appendModeProvider),
              onChanged: (v) => ref.read(appendModeProvider.notifier).update(),
            ),
            const Spacer(),
            EasyTextBtn(addFileLabel, onTap: addFile),
            const SizedBox(width: gap),
            EasyTextBtn(addFolderLabel, onTap: addFolder),
          ],
        ),
        const SizedBox(height: gap),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [DeleteSelectedButton(), DeleteFolderButton()],
        ),
        const SizedBox(height: gap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EasyCheckbox(
              S.of(context).topParentFolder,
              checked: ref.watch(useTopFolderProvider),
              onChanged: (v) =>
                  ref.read(useTopFolderProvider.notifier).update(),
            ),
            OrganizeButton(),
          ],
        ),
      ],
    );
  }
}
