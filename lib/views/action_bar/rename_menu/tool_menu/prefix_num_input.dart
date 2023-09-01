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

class PrefixNumInput extends ConsumerWidget {
  const PrefixNumInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String prefixSwapTip = '交换前缀和递增数字位置';
    const String increaseLabel = '增数';

    // 位数
    const int defaultPrefixNumLength = 0;
    const String prefixNumLengthLabel = '位';
    // 开始数
    const int defaultPrefixNumStart = 0;
    const String prefixNumStartLabel = '开始';

    TextEditingController lengthController =
        ref.watch(prefixLengthControllerProvider);
    TextEditingController startController =
        ref.watch(prefixStartControllerProvider);

    return CommonInputMenu(
      label: increaseLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: lengthController,
              value: defaultPrefixNumLength,
              label: prefixNumLengthLabel,
              callback: () async {
                updateName(ref);
                int num = int.parse(lengthController.text.replaceAll('位', ''));
                await StorageUtil.setInt(AppKeys.prefixLength, num);
              },
              onChanged: (v) async {
                updateName(ref);
                await StorageUtil.setInt(AppKeys.prefixLength, int.parse(v));
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: DigitInput(
              controller: startController,
              value: defaultPrefixNumStart,
              label: prefixNumStartLabel,
              callback: () async {
                updateName(ref);
                int num = int.parse(startController.text.replaceAll('开始', ''));
                await StorageUtil.setInt(AppKeys.prefixStart, num);
              },
              onChanged: (v) async {
                updateName(ref);
                await StorageUtil.setInt(AppKeys.prefixStart, int.parse(v));
              },
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
