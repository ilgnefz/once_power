import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/views/action_bar/tool_menu/date_text_input.dart';
import 'package:once_power/views/action_bar/tool_menu/differ_menu.dart';
import 'package:once_power/views/action_bar/tool_menu/file_extension_input.dart';
import 'package:once_power/views/action_bar/tool_menu/modify_text_input.dart';
import 'package:once_power/views/action_bar/tool_menu/prefix_num_input.dart';
import 'package:once_power/views/action_bar/tool_menu/prefix_text_input.dart';
import 'package:once_power/views/action_bar/tool_menu/suffix_num_input.dart';
import 'package:once_power/views/action_bar/tool_menu/suffix_text_input.dart';

import 'match_text_input.dart';

class ToolMenu extends ConsumerWidget {
  const ToolMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 匹配内容
        MatchTextInput(),
        SizedBox(height: AppNum.gapW),
        // 不同菜单
        DifferMenu(),
        SizedBox(height: AppNum.gapW),
        ModifyTextInput(),
        SizedBox(height: AppNum.gapW),
        // 日期命名方式
        DateTextInput(),
        SizedBox(height: AppNum.gapW),
        // 前缀
        PrefixTextInput(),
        SizedBox(height: AppNum.gapW),
        // 前缀递增数
        PrefixNumInput(),
        SizedBox(height: AppNum.gapW),
        // 后缀
        SuffixTextInput(),
        SizedBox(height: AppNum.gapW),
        // 后缀递增数
        SuffixNumInput(),
        SizedBox(height: AppNum.gapW),
        // 文件后缀名
        FileExtensionInput(),
      ],
    );
  }
}
