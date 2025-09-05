import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/views/action/rename/date_dropdown.dart';
import 'package:once_power/widgets/action/action_item.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class DateInput extends ConsumerWidget {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: tr(AppL10n.renameDate),
      tip: tr(AppL10n.renameDateRename),
      icon: AppIcons.date,
      checked: ref.watch(isDateRenameProvider),
      onPressed: () {
        ref.read(isDateRenameProvider.notifier).update();
        if (ref.watch(isDateRenameProvider)) {
          ref.read(matchControllerProvider.notifier).clear();
          ref.read(modifyControllerProvider.notifier).clear();
        }
        Debounce.run(() => updateName(ref));
      },
      child: Row(
        spacing: AppNum.paddingMedium,
        children: [
          Expanded(
            child: DigitInput(
              value: ref.watch(dateLenProvider),
              unit: tr(AppL10n.renameDigits),
              max: 14,
              onChange: (value) {
                ref.read(dateLenProvider.notifier).update(value);
                Debounce.run(() => updateName(ref));
              },
            ),
          ),
          Expanded(child: DateDropdown()),
        ],
      ),
    );
  }
}
