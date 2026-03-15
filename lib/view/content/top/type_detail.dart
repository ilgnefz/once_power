import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/select.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/button.dart';

import 'extension.dart';
import 'path.dart';

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
      content: SingleChildScrollView(
        child: isPath ? PathList() : ExtensionArea(),
      ),
      actionsAxisAlignment: MainAxisAlignment.center,
      actionsSpacing: AppNum.spaceMedium,
      actions: [
        EasyButton(
          label: tr(AppL10n.contentFilterUnselected),
          onPressed: () {
            ref.read(fileListProvider.notifier).removeUncheck();
            if (ref.watch(fileListProvider).isEmpty) Navigator.pop(context);
          },
        ),
        EasyButton(
          label: tr(AppL10n.contentFilterSelected),
          onPressed: () {
            ref.read(fileListProvider.notifier).removeCheck();
            if (ref.watch(fileListProvider).isEmpty) Navigator.pop(context);
          },
        ),
        EasyButton(
          label: tr(AppL10n.contentFilterReserve),
          onPressed: () {
            ref.read(fileListProvider.notifier).checkReverse();
            updateName(ref);
          },
        ),
        EasyButton(
          label: tr(AppL10n.dialogToggle),
          onPressed: () => selectAll(ref),
        ),
        EasyButton(
          label: tr(AppL10n.dialogExitOperate),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
