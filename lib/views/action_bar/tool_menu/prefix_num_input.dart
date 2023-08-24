import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/digit_input.dart';

class PrefixNumInput extends HookConsumerWidget {
  const PrefixNumInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String prefixSwapTip = '交换前缀和递增数字位置';
    const String increaseLabel = '增数';

    // 位数
    const int defaultPrefixNumLength = 0;
    const String prefixNumLengthLabel = '位';
    // final prefixNumLengthController = useTextEditingController(
    //   text: '$defaultPrefixNumLength$prefixNumLengthLabel',
    // );
    // prefixNumLengthController.addListener(() {
    //   String num = prefixNumLengthController.text.isEmpty
    //       ? defaultPrefixNumLength.toString()
    //       : prefixNumLengthController.text.replaceAll(prefixNumLengthLabel, '');
    //   ref.read(prefixNumLengthProvider.notifier).update(int.parse(num));
    // });
    // 开始数
    const int defaultPrefixNumStart = 0;
    const String prefixNumStartLabel = '开始';
    // final prefixNumStartController = useTextEditingController(
    //   text: '$defaultPrefixNumStart$prefixNumStartLabel',
    // );
    // prefixNumStartController.addListener(() {
    //   String num = prefixNumStartController.text.isEmpty
    //       ? defaultPrefixNumStart.toString()
    //       : prefixNumStartController.text.replaceAll(prefixNumStartLabel, '');
    //   ref.read(prefixNumStartProvider.notifier).update(int.parse(num));
    // });

    return CommonInputMenu(
      label: increaseLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: ref.watch(prefixLengthControllerProvider),
              value: defaultPrefixNumLength,
              label: prefixNumLengthLabel,
              callback: () => updateName(ref),
              onChanged: (v) => updateName(ref),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: DigitInput(
              controller: ref.watch(prefixStartControllerProvider),
              value: defaultPrefixNumStart,
              label: prefixNumStartLabel,
              callback: () => updateName(ref),
              onChanged: (v) => updateName(ref),
            ),
          ),
        ],
      ),
      onChanged: (v) => updateName(ref),
      message: prefixSwapTip,
      icon: AppIcons.swap,
      selected: ref.watch(swapPrefixProvider),
      onTap: () {
        ref.read(swapPrefixProvider.notifier).update();
        updateName(ref);
      },
    );
  }
}
