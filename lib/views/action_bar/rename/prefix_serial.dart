import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/action_bar/operate_item.dart';

class PrefixSerial extends ConsumerWidget {
  const PrefixSerial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OperateItem(
      label: S.of(context).serial,
      icon: AppIcons.swap,
      tip: S.of(context).swapPrefixDesc,
      selected: ref.watch(isSwapPrefixProvider),
      onToggle: () {
        ref.read(isSwapPrefixProvider.notifier).update();
        updateName(ref);
      },
      child: Row(
        spacing: AppNum.mediumG,
        children: [
          Expanded(
            child: DigitInput(
              value: ref.watch(prefixSerialLengthProvider),
              label: S.of(context).digits,
              onChanged: (value) {
                ref.read(prefixSerialLengthProvider.notifier).update(value);
                updateName(ref);
              },
            ),
          ),
          Expanded(
            child: DigitInput(
              value: ref.watch(prefixSerialStartProvider),
              label: S.of(context).start,
              onChanged: (value) {
                ref.read(prefixSerialStartProvider.notifier).update(value);
                updateName(ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}
