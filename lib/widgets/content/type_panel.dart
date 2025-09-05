import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/select.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/content/dialog/ext_area.dart';
import 'package:once_power/views/content/dialog/path_list.dart';
import 'package:once_power/widgets/base/easy_btn.dart';
import 'package:once_power/widgets/base/easy_dialog.dart';

class TypeDetailPanel extends ConsumerWidget {
  const TypeDetailPanel({super.key, this.isPath = false});

  final bool isPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyDialog(
      width: AppNum.detailDialog,
      title: isPath ? tr(AppL10n.dialogFolder) : tr(AppL10n.dialogExt),
      padding: EdgeInsets.only(
        left: AppNum.padding,
        top: AppNum.padding,
        bottom: AppNum.padding,
      ),
      content: Flexible(child: isPath ? PathList() : ExtensionArea()),
      actionsAxisAlignment: MainAxisAlignment.center,
      actionsSpacing: AppNum.spaceMedium,
      actions: [
        EasyBtn(
          label: tr(AppL10n.contentFilterUnselected),
          onPressed: () {
            ref.read(fileListProvider.notifier).removeUncheck();
            if (ref.watch(fileListProvider).isEmpty) Navigator.pop(context);
          },
        ),
        EasyBtn(
          label: tr(AppL10n.contentFilterSelected),
          onPressed: () {
            ref.read(fileListProvider.notifier).removeCheck();
            if (ref.watch(fileListProvider).isEmpty) Navigator.pop(context);
          },
        ),
        EasyBtn(
          label: tr(AppL10n.contentFilterReserve),
          onPressed: () {
            ref.read(fileListProvider.notifier).checkReverse();
            updateName(ref);
          },
        ),
        EasyBtn(
          label: tr(AppL10n.dialogToggle),
          onPressed: () => selectAll(ref),
        ),
        EasyBtn(
          label: tr(AppL10n.dialogExitOperate),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
