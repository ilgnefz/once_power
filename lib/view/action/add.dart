import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/base/checkbox.dart';
import 'package:once_power/widget/base/icon.dart';

class AddGroup extends ConsumerWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNumber.paddingSmall,
        right: AppNumber.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: ref.watch(isAddFolderProvider),
            label: context.tr(AppL10n.addFolder),
            onChanged: (v) => ref.read(isAddFolderProvider.notifier).toggle(),
            child: ClickIcon(
              tip: context.tr(AppL10n.addSubfolder),
              icon: Icons.folder_copy_rounded,
              iconSize: 14,
              size: 22,
              color: ref.watch(isAddSubfolderProvider)
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              onPressed: ref.read(isAddSubfolderProvider.notifier).toggle,
            ),
          ),
          EasyCheckbox(
            checked: ref.watch(isAppendProvider),
            label: context.tr(AppL10n.append),
            onChanged: (v) => ref.read(isAppendProvider.notifier).toggle(),
          ),
        ],
      ),
    );
  }
}
