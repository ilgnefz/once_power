import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/action_bar/csv_data/csv_data.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_checkbox.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

import 'apply_menu/apply_menu.dart';
import 'tool_menu/tool_menu.dart';

class RenameMenu extends ConsumerWidget {
  const RenameMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasCSVData = ref.watch(cSVDataProvider).isNotEmpty;

    return Column(
      children: [
        Expanded(
            child: hasCSVData
                ? const CsvDataView()
                : const SingleChildScrollView(child: ToolMenu())),
        const SizedBox(height: AppNum.gapH),
        Consumer(
          builder: (context, ref, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckbox(
                S.of(context).appendMode,
                checked: ref.watch(appendModeProvider),
                onChanged: (v) =>
                    ref.read(appendModeProvider.notifier).update(),
              ),
              Row(
                children: [
                  CustomCheckbox(
                    S.of(context).addFolder,
                    checked: ref.watch(addFolderProvider),
                    onChanged: (v) =>
                        ref.read(addFolderProvider.notifier).update(),
                  ),
                  const SizedBox(width: 4),
                  CustomTooltip(
                    message: S.of(context).addSubfolder,
                    textStyle:
                        const TextStyle(fontSize: 13, color: Color(0xFF666666))
                            .useSystemChineseFont(),
                    placement: Placement.right,
                    child: ClickIcon(
                      size: 24,
                      svg: AppIcons.folder,
                      color: ref.watch(addSubfolderProvider)
                          ? Theme.of(context).primaryColor
                          : AppColors.unselectIcon,
                      onTap: ref.read(addSubfolderProvider.notifier).update,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: AppNum.gapH),
        const ApplyMenu(),
      ],
    );
  }
}
