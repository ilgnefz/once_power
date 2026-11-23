import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/base/dropdown.dart';
import 'package:once_power/widget/base/radio.dart';

class AddIndexRule extends StatelessWidget {
  const AddIndexRule({
    super.key,
    required this.rule,
    required this.onRuleChanged,
    required this.dateType,
    required this.onDateTypeChange,
  });

  final IndexRule rule;
  final void Function(IndexRule value) onRuleChanged;
  final DateType dateType;
  final void Function(DateType value) onDateTypeChange;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<IndexRule>(
      groupValue: rule,
      onChanged: (value) => onRuleChanged(value!),
      child: DialogItem(
        title: context.tr(AppL10n.addIndexRule),
        spacing: AppNumber.space,
        children: IndexRule.values.map((e) {
          return EasyRadio(
            label: e.label,
            value: e,
            trailing: e.isDate
                ? EasyTextDropdown<DateType>(
                    items: DateType.values.map((item) {
                      return TextDropdownItem(item, label: item.label);
                    }).toList(),
                    value: dateType,
                    width: 100,
                    onChanged: onDateTypeChange,
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}
