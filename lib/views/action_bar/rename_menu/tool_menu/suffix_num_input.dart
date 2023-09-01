import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/digit_input.dart';

class SuffixNumInput extends ConsumerWidget {
  const SuffixNumInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String suffixSwapTip = '交换后缀和递增数字位置';
    const String increaseLabel = '增数';

    // 数字位数
    const int defaultSuffixNumLength = 0;
    const String suffixNumLengthLabel = '位';

    // 数字开始数
    const int defaultSuffixNumStart = 0;
    const String suffixNumStartLabel = '开始';

    TextEditingController lengthController =
        ref.watch(suffixLengthControllerProvider);
    TextEditingController startController =
        ref.watch(suffixStartControllerProvider);

    return CommonInputMenu(
      label: increaseLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: lengthController,
              value: defaultSuffixNumLength,
              label: suffixNumLengthLabel,
              callback: () async {
                updateName(ref);
                int num = int.parse(lengthController.text.replaceAll('位', ''));
                await StorageUtil.setInt(AppKeys.suffixLength, num);
              },
              onChanged: (v) async {
                updateName(ref);
                await StorageUtil.setInt(AppKeys.suffixLength, int.parse(v));
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: DigitInput(
              controller: startController,
              value: defaultSuffixNumStart,
              label: suffixNumStartLabel,
              callback: () async {
                updateName(ref);
                int num = int.parse(startController.text.replaceAll('开始', ''));
                await StorageUtil.setInt(AppKeys.suffixStart, num);
              },
              onChanged: (v) async {
                updateName(ref);
                await StorageUtil.setInt(AppKeys.suffixStart, int.parse(v));
              },
            ),
          ),
        ],
      ),
      message: suffixSwapTip,
      icon: AppIcons.swap,
      selected: ref.watch(swapSuffixProvider),
      onTap: () {
        ref.read(swapSuffixProvider.notifier).update();
        updateName(ref);
      },
    );
  }
}
