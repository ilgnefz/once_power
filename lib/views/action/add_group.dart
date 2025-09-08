import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class AddGroup extends ConsumerWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: ref.watch(isAddFolderProvider),
            label: tr(AppL10n.actionAddFolder),
            onChanged: (v) => ref.read(isAddFolderProvider.notifier).update(),
            child: Consumer(
              builder: (_, ref, __) => EasyTooltip(
                tip: tr(AppL10n.actionFolderTip),
                child: ClickIcon(
                  icon: Icons.folder_copy_rounded,
                  iconSize: 16,
                  color: ref.watch(isAddSubfolderProvider)
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  onPressed: ref.read(isAddSubfolderProvider.notifier).update,
                ),
              ),
            ),
          ),
          EasyCheckbox(
            checked: ref.watch(isAppendModeProvider),
            label: tr(AppL10n.actionAppend),
            onChanged: (v) => ref.read(isAppendModeProvider.notifier).update(),
          ),
        ],
      ),
    );
  }
}
