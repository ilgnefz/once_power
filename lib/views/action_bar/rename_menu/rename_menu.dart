import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/easy_checkbox.dart';

import 'apply_menu/apply_menu.dart';
import 'tool_menu/tool_menu.dart';

class RenameMenu extends StatelessWidget {
  const RenameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const String appendMode = '追加模式';
    const String addFolder = '添加文件夹';

    return Column(
      children: [
        const Expanded(child: SingleChildScrollView(child: ToolMenu())),
        Consumer(
          builder: (context, ref, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyCheckbox(
                appendMode,
                checked: ref.watch(appendModeProvider),
                onChanged: (v) =>
                    ref.read(appendModeProvider.notifier).update(),
              ),
              EasyCheckbox(
                addFolder,
                checked: ref.watch(addFolderProvider),
                onChanged: (v) => ref.read(addFolderProvider.notifier).update(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppNum.gapH),
        const ApplyMenu(),
      ],
    );
  }
}
