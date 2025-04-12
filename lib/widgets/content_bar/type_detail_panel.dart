import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/views/content_bar/detail_extension_area.dart';
import 'package:once_power/views/content_bar/path_classify_list.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';
import 'package:once_power/widgets/action_bar/easy_dialog.dart';

class TypeDetailPanel extends ConsumerWidget {
  const TypeDetailPanel({super.key, this.isPath = false});

  final bool isPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double gepM = AppNum.mediumG;

    return EasyDialog(
      width: AppNum.detailDialogW,
      title: isPath ? S.of(context).allFolderTitle : S.of(context).detailTitle,
      extraContent: isPath
          ? PathClassifyList()
          : SingleChildScrollView(
              child: Column(
                children: ref.watch(extensionListMapProvider).entries.map((e) {
                  return DetailExtensionArea(
                    label: e.key.label,
                    extList: e.value,
                  );
                }).toList(),
              ),
            ),
      actionsAxisAlignment: MainAxisAlignment.center,
      actionsSpacing: gepM,
      actions: [
        EasyBtn(
          S.of(context).removeUnselected,
          onTap: () {
            ref.read(fileListProvider.notifier).removeUncheck();
            if (ref.watch(fileListProvider).isEmpty) {
              Navigator.pop(context);
            }
          },
        ),
        EasyBtn(
          S.of(context).removeSelected,
          onTap: () {
            ref.read(fileListProvider.notifier).removeCheck();
            if (ref.watch(fileListProvider).isEmpty) {
              Navigator.pop(context);
            }
          },
        ),
        EasyBtn(
          S.of(context).selectReserve,
          onTap: () {
            ref.read(fileListProvider.notifier).checkReverse();
            updateName(ref);
          },
        ),
        EasyBtn(
          S.of(context).selectAllSwitch,
          onTap: () => selectAll(ref),
        ),
        EasyBtn(
          S.of(context).exitOperation,
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
