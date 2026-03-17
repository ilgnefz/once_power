import 'package:flutter/material.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/checkbox.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: '设置',
      content: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text('配置'),
          EasyCheckbox(checked: true, label: '保存窗口大小', onChanged: (v) {}),
          EasyCheckbox(checked: true, label: '保存窗口位置', onChanged: (v) {}),
          EasyCheckbox(checked: true, label: '保存窗口位置', onChanged: (v) {}),
          EasyCheckbox(checked: true, label: '保存窗口位置', onChanged: (v) {}),
        ],
      ),
      onOk: () {},
    );
  }
}
