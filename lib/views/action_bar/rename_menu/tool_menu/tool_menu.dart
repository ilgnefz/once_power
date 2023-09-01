import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';

import 'date_text_input.dart';
import 'differ_menu.dart';
import 'file_extension_input.dart';
import 'match_text_input.dart';
import 'modify_text_input.dart';
import 'prefix_num_input.dart';
import 'prefix_text_input.dart';
import 'suffix_num_input.dart';
import 'suffix_text_input.dart';

class ToolMenu extends ConsumerWidget {
  const ToolMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 匹配内容
        MatchTextInput(),
        SizedBox(height: AppNum.gapH),
        // 不同菜单
        DifferMenu(),
        SizedBox(height: AppNum.gapH),
        ModifyTextInput(),
        SizedBox(height: AppNum.gapH),
        // 日期命名方式
        DateTextInput(),
        SizedBox(height: AppNum.gapH),
        // 前缀
        PrefixTextInput(),
        SizedBox(height: AppNum.gapH),
        // 前缀递增数
        PrefixNumInput(),
        SizedBox(height: AppNum.gapH),
        // 后缀
        SuffixTextInput(),
        SizedBox(height: AppNum.gapH),
        // 后缀递增数
        SuffixNumInput(),
        SizedBox(height: AppNum.gapH),
        // 文件后缀名
        FileExtensionInput(),
      ],
    );
  }
}
