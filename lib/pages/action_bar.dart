import 'package:flutter/material.dart';
import 'package:once_power/pages/operate_group.dart';
import 'package:once_power/provider/action.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:provider/provider.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActionProvider>(context);
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(child: OperateGroup(provider))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleCheckbox(
              title: '追加模式',
              checked: provider.appendMode,
              onChange: (v) => provider.switchUse('appendMode'),
            ),
            SimpleCheckbox(
              title: '添加文件夹',
              checked: provider.folderMode,
              onChange: (v) => provider.switchUse('folderMode'),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: provider.folderMode ? null : provider.getFile,
              child: const MyText('选择文件'),
            ),
            TextButton(
              onPressed: provider.getDir,
              child: const MyText('选择文件夹'),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            IconButton(
              onPressed: provider.clearFiles,
              icon: const Icon(Icons.delete),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: provider.applyChange,
              child: const MyText('应用更改'),
            ),
          ],
        ),
      ],
    );
  }
}
