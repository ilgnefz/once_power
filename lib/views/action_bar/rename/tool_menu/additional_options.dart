import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/custom_tooltip.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class AdditionalOptions extends ConsumerWidget {
  const AdditionalOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EasyCheckbox(
              S.of(context).caseClassify,
              checked: ref.watch(caseClassifyProvider),
              onChanged: (v) {
                ref.read(caseClassifyProvider.notifier).update();
                updateName(ref);
              },
            ),
            EasyCheckbox(
              S.of(context).caseExtension,
              checked: ref.watch(caseExtensionProvider),
              onChanged: (v) {
                ref.read(caseExtensionProvider.notifier).update();
                updateName(ref);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                EasyCheckbox(
                  S.of(context).addFolder,
                  checked: ref.watch(addFolderProvider),
                  onChanged: (v) =>
                      ref.read(addFolderProvider.notifier).update(),
                ),
                const SizedBox(width: AppNum.mediumG),
                EasyTooltip(
                  message: S.of(context).addSubfolder,
                  textStyle:
                      const TextStyle(fontSize: 13, color: Color(0xFF666666))
                          .useSystemChineseFont(),
                  placement: Placement.right,
                  child: ClickIcon(
                    size: 18,
                    icon: Icons.folder_copy_rounded,
                    color: ref.watch(addSubfolderProvider)
                        ? Theme.of(context).primaryColor
                        : AppColors.unselectIcon,
                    onTap: ref.read(addSubfolderProvider.notifier).update,
                  ),
                ),
              ],
            ),
            EasyCheckbox(
              S.of(context).appendMode,
              checked: ref.watch(appendModeProvider),
              onChanged: (v) => ref.read(appendModeProvider.notifier).update(),
            ),
          ],
        ),
      ],
    );
  }
}
