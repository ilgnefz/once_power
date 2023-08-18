import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

class MatchTextInput extends HookConsumerWidget {
  const MatchTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool useLength = ref.watch(inputLengthProvider);
    final String matchTextHint = useLength ? '输入数字或指定长度字符串' : '请输入内容';
    const String lengthTip = '输入长度截取（两个数字之间加空格截取中间部分）';

    final matchTextController = useTextEditingController();
    final matchInputShow = useState(false);
    matchTextController.addListener(() {
      matchInputShow.value = matchTextController.text.isNotEmpty;
      ref.read(matchTextProvider.notifier).update(matchTextController.text);
    });

    return CommonInputMenu(
      controller: matchTextController,
      hintText: matchTextHint,
      show: matchInputShow.value,
      message: lengthTip,
      icon: AppIcons.ruler,
      selected: ref.watch(inputLengthProvider),
      onTap: ref.read(inputLengthProvider.notifier).update,
    );
  }
}
