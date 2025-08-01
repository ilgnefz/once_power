import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/views/action_bar/rename/date_dropdown.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/action_bar/operate_item.dart';

class DateInput extends ConsumerWidget {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OperateItem(
      label: S.of(context).date,
      icon: AppIcons.date,
      tip: S.of(context).dateDesc,
      selected: ref.watch(isDateRenameProvider),
      onToggle: () {
        FunctionMode mode = ref.watch(currentModeProvider);
        if (mode.isReplace) {
          ref.read(modifyControllerProvider.notifier).clear();
        }
        if (mode.isReserve) {
          ref.read(matchControllerProvider.notifier).clear();
          ref.read(modifyControllerProvider.notifier).clear();
          ref.read(currentReserveTypeProvider.notifier).clear();
        }
        ref.read(isDateRenameProvider.notifier).update();
        updateName(ref);
      },
      child: Row(
        spacing: AppNum.operateG,
        children: [
          Expanded(
            child: DigitInput(
              value: ref.watch(dateLengthValueProvider),
              label: S.of(context).digits,
              onChanged: (value) {
                ref.read(dateLengthValueProvider.notifier).update(value);
                updateName(ref);
              },
            ),
          ),
          Expanded(child: DateDropdown()),
        ],
      ),
    );
  }
}
