import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/views/action_bar/tool_menu.dart';
import 'package:once_power/widgets/easy_checkbox.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppNum.actionBarP),
      width: AppNum.actionBarW,
      child: Column(
        children: [
          const Expanded(child: SingleChildScrollView(child: ToolMenu())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyCheckbox('追加模式', checked: true, onChanged: (v) {}),
              EasyCheckbox('添加文件夹', checked: true, onChanged: (v) {}),
            ],
          ),
          const SizedBox(height: AppNum.gapH),
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('选择文件')),
              TextButton(onPressed: () {}, child: Text('选择文件夹')),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text('应用更改'),
                // style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
