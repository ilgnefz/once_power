import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/view/action/advanced/dialog/add_index_rule.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/number_input.dart';

class AddIndexGroup extends StatelessWidget {
  const AddIndexGroup({
    super.key,
    required this.selected,
    required this.digit,
    required this.onDigitChanged,
    required this.start,
    required this.onStartChanged,
    required this.step,
    required this.onStepChanged,
    required this.rule,
    required this.onRuleChanged,
    required this.dateType,
    required this.onDateTypeChange,
  });

  final bool selected;
  final int digit;
  final ValueChanged<int> onDigitChanged;
  final int start;
  final ValueChanged<int> onStartChanged;
  final int step;
  final ValueChanged<int> onStepChanged;
  final IndexRule rule;
  final ValueChanged<IndexRule> onRuleChanged;
  final DateType dateType;
  final ValueChanged<DateType> onDateTypeChange;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppNumber.spaceMedium,
        children: [
          DialogItem(
            title: context.tr(AppL10n.indexFormat),
            spacing: AppNumber.spaceSmall,
            children: [
              const SizedBox.shrink(),
              SizedBox(
                width: 120,
                child: NumberInput(
                  value: digit,
                  unit: tr(AppL10n.digit),
                  min: 1,
                  onChanged: onDigitChanged,
                ),
              ),
              SizedBox(
                width: 120,
                child: NumberInput(
                  value: start,
                  unit: tr(AppL10n.start),
                  onChanged: onStartChanged,
                ),
              ),
              SizedBox(
                width: 120,
                child: NumberInput(
                  value: step,
                  min: 1,
                  unit: tr(AppL10n.indexStep),
                  onChanged: onStepChanged,
                ),
              ),
            ],
          ),
          AddIndexRule(
            rule: rule,
            onRuleChanged: onRuleChanged,
            dateType: dateType,
            onDateTypeChange: onDateTypeChange,
          ),
        ],
      ),
    );
  }
}
