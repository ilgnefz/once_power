import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/action_item.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class SuffixSerial extends ConsumerWidget {
  const SuffixSerial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: tr(AppL10n.renameSerial),
      tip: tr(AppL10n.renameSuffixSwap),
      icon: AppIcons.swap,
      checked: ref.watch(isSwapSuffixProvider),
      onPressed: () {
        ref.read(isSwapSuffixProvider.notifier).update();
        Debounce.run(() => updateName(ref));
      },
      child: Row(
        spacing: AppNum.paddingMedium,
        children: [
          Expanded(
            child: DigitInput(
              value: ref.watch(suffixSerialLenProvider),
              unit: tr(AppL10n.renameDigits),
              onChanged: (value) {
                ref.read(suffixSerialLenProvider.notifier).update(value);
                Debounce.run(() => updateName(ref));
              },
            ),
          ),
          Expanded(
            child: DigitInput(
              value: ref.watch(suffixSerialStartProvider),
              unit: tr(AppL10n.renameStart),
              onChanged: (value) {
                ref.read(suffixSerialStartProvider.notifier).update(value);
                Debounce.run(() => updateName(ref));
              },
            ),
          ),
        ],
      ),
    );
  }
}
