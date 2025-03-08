import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class AddFolderCheckbox extends ConsumerWidget {
  const AddFolderCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: AppNum.smallG,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        EasyCheckbox(
          checked: ref.watch(isAddFolderProvider),
          onChanged: (value) => ref.read(isAddFolderProvider.notifier).update(),
          child: Text(S.of(context).addFolder),
        ),
        TooltipIcon(
          tip: S.of(context).addSubfolder,
          placement: Placement.right,
          size: 18,
          icon: Icons.folder_copy_rounded,
          color: ref.watch(isAddSubfolderProvider)
              ? Theme.of(context).primaryColor
              : AppColors.unselectIcon,
          onTap: ref.read(isAddSubfolderProvider.notifier).update,
        ),
      ],
    );
  }
}
