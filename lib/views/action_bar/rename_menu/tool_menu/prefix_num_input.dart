import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/input/input.dart';

class PrefixNumInput extends ConsumerWidget {
  const PrefixNumInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String swapPrefixTip = S.of(context).swapPrefixDesc;
    final String increaseLabel = S.of(context).serial;

    // 位数
    const int defaultPrefixNumLength = 0;
    final String prefixNumLengthLabel = S.of(context).digits;
    // 开始数
    const int defaultPrefixNumStart = 0;
    final String prefixNumStartLabel = S.of(context).start;

    TextEditingController lengthController =
        ref.watch(prefixLengthControllerProvider);
    TextEditingController startController =
        ref.watch(prefixStartControllerProvider);

    void getLengthNum() async {
      updateName(ref);
      int num = getNum(lengthController.text);
      await StorageUtil.setInt(AppKeys.prefixLength, num);
    }

    void lengthNumInput(v) async {
      updateName(ref);
      await StorageUtil.setInt(AppKeys.prefixLength, int.parse(v));
    }

    void getStartNum() async {
      updateName(ref);
      int num = getNum(startController.text);
      await StorageUtil.setInt(AppKeys.prefixStart, num);
    }

    void startNumInput(v) async {
      updateName(ref);
      await StorageUtil.setInt(AppKeys.prefixStart, int.parse(v));
    }

    void toggleSwap() {
      ref.read(swapPrefixProvider.notifier).update();
      updateName(ref);
    }

    return CommonInputMenu(
      label: increaseLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: lengthController,
              value: defaultPrefixNumLength,
              label: prefixNumLengthLabel,
              callback: getLengthNum,
              onChanged: lengthNumInput,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: DigitInput(
              controller: startController,
              value: defaultPrefixNumStart,
              label: prefixNumStartLabel,
              callback: getStartNum,
              onChanged: startNumInput,
            ),
          ),
        ],
      ),
      onChanged: (v) => updateName(ref),
      message: swapPrefixTip,
      icon: AppIcons.swap,
      selected: ref.watch(swapPrefixProvider),
      onTap: toggleSwap,
    );
  }
}
