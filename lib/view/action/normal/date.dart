import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/switch.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/action/number_input.dart';
import 'package:once_power/widget/base/dropdown.dart';

class DateInput extends ConsumerWidget {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Localizations.localeOf(context);
    return ActionItem(
      label: context.tr(AppL10n.date),
      icon: AppIcons.dateRename,
      tip: context.tr(AppL10n.dateRename),
      checked: ref.watch(isDateRenameProvider),
      onIconPressed: ref.read(isDateRenameProvider.notifier).toggle,
      child: Row(
        spacing: AppNumber.spaceSmall,
        children: [
          Expanded(
            child: NumberInput(
              unit: context.tr(AppL10n.digit),
              value: ref.watch(dateDigitsProvider),
              max: 14,
              onChanged: ref.read(dateDigitsProvider.notifier).update,
            ),
          ),
          Expanded(
            child: EasyTextDropdown<DateType>(
              width: 108,
              value: ref.watch(currentDateProvider),
              items: DateType.values.map((value) {
                return TextDropdownItem<DateType>(value, label: value.label);
              }).toList(),
              onChanged: ref.read(currentDateProvider.notifier).update,
            ),
          ),
        ],
      ),
    );
  }
}
