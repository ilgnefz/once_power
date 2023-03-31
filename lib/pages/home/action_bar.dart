import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:provider/provider.dart';

import 'operate_group.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RenameProvider>(context);
    final otherProvider = Provider.of<OtherProvider>(context);
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(child: OperateGroup(provider))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleCheckbox(
              title: S.of(context).appendMode,
              checked: provider.appendMode,
              onChange: (v) => provider.toggleCheck('appendMode'),
            ),
            SimpleCheckbox(
              title: S.of(context).addFolder,
              checked: provider.addFolder,
              onChange: (v) => provider.toggleCheck('addFolder'),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: provider.addFolder ? null : provider.selectFileAdd,
              child: MyText(S.of(context).selectFile),
            ),
            TextButton(
              onPressed: provider.selectFolderAdd,
              child: MyText(S.of(context).selectFolder),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                otherProvider.switchPage(true);
                provider.toOther(context);
              },
              icon: const Icon(Icons.menu_rounded),
            ),
            IconButton(
              onPressed: provider.clearFiles,
              icon: const Icon(Icons.delete),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: provider.selectedFilesCount == 0
                  ? null
                  : provider.applyChange,
              child: MyText(S.of(context).applyChange),
            ),
          ],
        ),
      ],
    );
  }
}
