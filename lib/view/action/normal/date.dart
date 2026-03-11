import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

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
        Debounce.run(() => normalUpdateName(ref));
      },
      child: Row(
        spacing: AppNum.spaceMedium,
        children: [
          DigitInput(
            value: ref.watch(dateDigitProvider),
            unit: tr(AppL10n.renameDigits),
            max: 14,
            onChanged: (value) {
              ref.read(dateDigitProvider.notifier).update(value);
              Debounce.run(() => normalUpdateName(ref));
            },
          ),
          Expanded(
            child: TextDropdown<DateType>(
              items: DateType.values
                  .map(
                    (e) => DropdownItem(
                      value: e,
                      key: ValueKey(e),
                      height: AppNum.widgetHeight,
                      child: BaseText(e.label),
                    ),
                  )
                  .toList(),
              value: ref.watch(currentDateTypeProvider),
              onChanged: (value) {
                ref.read(currentDateTypeProvider.notifier).update(value);
                Debounce.run(() => normalUpdateName(ref));
              },
            ),
          ),
        ],
      ),
    );
  }
}
