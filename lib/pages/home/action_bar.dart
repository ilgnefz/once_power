import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
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
              checked: provider.folderMode,
              onChange: (v) => provider.toggleCheck('folderMode'),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: provider.folderMode ? null : provider.getFile,
              child: MyText(S.of(context).selectFile),
            ),
            TextButton(
              onPressed: provider.getDir,
              child: MyText(S.of(context).selectFolder),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => provider.toOther(context),
              icon: const Icon(Icons.settings),
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
