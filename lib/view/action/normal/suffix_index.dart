import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/action/number_input.dart';

class SuffixIndexInput extends ConsumerWidget {
  const SuffixIndexInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: context.tr(AppL10n.index),
      icon: AppIcons.swap,
      tip: context.tr(AppL10n.suffixSwap),
      checked: ref.watch(isSwapSuffixProvider),
      onIconPressed: ref.read(isSwapSuffixProvider.notifier).toggle,
      child: Row(
        spacing: AppNumber.spaceSmall,
        children: [
          Expanded(
            child: NumberInput(
              unit: context.tr(AppL10n.digit),
              value: ref.watch(suffixDigitsProvider),
              onChanged: ref.read(suffixDigitsProvider.notifier).update,
            ),
          ),
          Expanded(
            child: NumberInput(
              unit: context.tr(AppL10n.start),
              value: ref.watch(suffixStartProvider),
              onChanged: ref.read(suffixStartProvider.notifier).update,
            ),
          ),
        ],
      ),
    );
  }
}
