import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/input/input.dart';

class SuffixNumInput extends ConsumerWidget {
  const SuffixNumInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String swapSuffixDesc = S.of(context).swapSuffixDesc;
    final String increaseLabel = S.of(context).serial;

    // 数字位数
    const int defaultSuffixNumLength = 0;
    final String suffixNumLengthLabel = S.of(context).digits;

    // 数字开始数
    const int defaultSuffixNumStart = 0;
    final String suffixNumStartLabel = S.of(context).start;

    TextEditingController lengthController =
        ref.watch(suffixLengthControllerProvider);
    TextEditingController startController =
        ref.watch(suffixStartControllerProvider);

    void getLengthNum() async {
      updateName(ref);
      int num =
          int.parse(lengthController.text.replaceAll(suffixNumLengthLabel, ''));
      await StorageUtil.setInt(AppKeys.suffixLength, num);
    }

    void lengthNumInput(v) async {
      updateName(ref);
      await StorageUtil.setInt(AppKeys.suffixLength, int.parse(v));
    }

    void getStartNum() async {
      updateName(ref);
      int num =
          int.parse(startController.text.replaceAll(suffixNumStartLabel, ''));
      await StorageUtil.setInt(AppKeys.suffixStart, num);
    }

    void startNumInput(v) async {
      updateName(ref);
      await StorageUtil.setInt(AppKeys.prefixStart, int.parse(v));
    }

    void toggleSwap() async {
      ref.read(swapSuffixProvider.notifier).update();
      updateName(ref);
    }

    return CommonInputMenu(
      label: increaseLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: lengthController,
              value: defaultSuffixNumLength,
              label: suffixNumLengthLabel,
              callback: getLengthNum,
              onChanged: lengthNumInput,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: DigitInput(
              controller: startController,
              value: defaultSuffixNumStart,
              label: suffixNumStartLabel,
              callback: getStartNum,
              onChanged: startNumInput,
            ),
          ),
        ],
      ),
      message: swapSuffixDesc,
      icon: AppIcons.swap,
      selected: ref.watch(swapSuffixProvider),
      onTap: toggleSwap,
    );
  }
}
