import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/action_bar/tool_menu/tool_menu.dart';
import 'package:once_power/widgets/click_text.dart';
import 'package:once_power/widgets/easy_checkbox.dart';
import 'package:once_power/widgets/mode_card.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    const String replaceLabel = '替换';
    const String reserveLabel = '保留';
    const String removeLabel = '删除';

    const String appendMode = '追加模式';
    const String addFolder = '添加文件夹';
    const String selectFile = '选择文件';
    const String selectFolder = '选择文件夹';
    const String applyChange = '应用更改';

    return Column(
      children: [
        Container(
          width: AppNum.actionBarW,
          height: AppNum.topMenuH,
          color: Colors.white,
          child: const Row(
            children: [
              ModeCard(label: replaceLabel, mode: FunctionMode.replace),
              ModeCard(label: reserveLabel, mode: FunctionMode.reserve),
              ModeCard(label: removeLabel, mode: FunctionMode.remove),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppNum.actionBarP),
            width: AppNum.actionBarW,
            child: Column(
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
                        onChanged: (v) =>
                            ref.read(addFolderProvider.notifier).update(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppNum.gapW),
                Row(
                  children: [
                    ClickText(selectFile, onTap: () {}),
                    ClickText(selectFolder, onTap: () {}),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(applyChange),
                      // style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
