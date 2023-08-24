import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

class MatchTextInput extends ConsumerWidget {
  const MatchTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool useLength = ref.watch(inputLengthProvider);
    final String matchTextHint = useLength ? '输入数字或指定长度字符串' : '请输入内容';
    const String disableHint = '输入已禁用';
    const String lengthTip = '输入长度截取（两个数字之间加空格截取中间部分）';
    bool disable = ref.watch(currentModeProvider) == FunctionMode.reserve &&
        (ref.watch(currentReserveTypeProvider).isNotEmpty ||
            ref.watch(dateRenameProvider));

    return CommonInputMenu(
      disable: disable,
      controller: ref.watch(matchControllerProvider),
      hintText: disable ? disableHint : matchTextHint,
      show: ref.watch(matchClearProvider),
      onChanged: (v) => updateName(ref),
      message: lengthTip,
      icon: AppIcons.ruler,
      selected: ref.watch(inputLengthProvider),
      onTap: () {
        ref.read(inputLengthProvider.notifier).update();
        updateName(ref);
      },
    );
  }
}
