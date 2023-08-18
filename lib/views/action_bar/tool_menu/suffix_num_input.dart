import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/digit_input.dart';

class SuffixNumInput extends HookConsumerWidget {
  const SuffixNumInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String suffixSwapTip = '交换后缀和递增数字位置';
    const String increaseLabel = '增数';

    // 数字位数
    const int defaultSuffixNumLength = 0;
    const String suffixNumLengthLabel = '位';
    final suffixNumLengthController = useTextEditingController(
      text: '$defaultSuffixNumLength$suffixNumLengthLabel',
    );
    suffixNumLengthController.addListener(() {
      String num = suffixNumLengthController.text.isEmpty
          ? defaultSuffixNumLength.toString()
          : suffixNumLengthController.text.replaceAll(suffixNumLengthLabel, '');
      ref.read(suffixNumLengthProvider.notifier).update(int.parse(num));
    });

    // 数字开始数
    const int defaultSuffixNumStart = 0;
    const String suffixNumStartLabel = '开始';
    final suffixNumStartController = useTextEditingController(
      text: '$defaultSuffixNumStart$suffixNumStartLabel',
    );
    suffixNumStartController.addListener(() {
      String num = suffixNumStartController.text.isEmpty
          ? defaultSuffixNumStart.toString()
          : suffixNumStartController.text.replaceAll(suffixNumStartLabel, '');
      ref.read(suffixNumStartProvider.notifier).update(int.parse(num));
    });

    return CommonInputMenu(
      label: increaseLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: suffixNumLengthController,
              value: defaultSuffixNumLength,
              label: suffixNumLengthLabel,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: DigitInput(
              controller: suffixNumStartController,
              value: defaultSuffixNumStart,
              label: suffixNumStartLabel,
            ),
          ),
        ],
      ),
      message: suffixSwapTip,
      icon: AppIcons.swap,
      selected: ref.watch(swapSuffixProvider),
      onTap: ref.read(swapSuffixProvider.notifier).update,
    );
  }
}
