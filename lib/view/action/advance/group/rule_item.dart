import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/input_field.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

class GroupRuleItem extends StatefulWidget {
  const GroupRuleItem({
    super.key,
    required this.isEnglish,
    required this.infoType,
    required this.operator,
    required this.value,
    required this.onInfoTypeChange,
    required this.onOperatorChange,
    required this.onValueChange,
    required this.onGroupChange,
  });

  final bool isEnglish;
  final InfoType infoType;
  final ComparisonOperator operator;
  final String value;
  final void Function(InfoType?) onInfoTypeChange;
  final void Function(ComparisonOperator?) onOperatorChange;
  final void Function(String?) onValueChange;
  final void Function(String?) onGroupChange;

  @override
  State<GroupRuleItem> createState() => _GroupRuleItemState();
}

class _GroupRuleItemState extends State<GroupRuleItem> {
  List<ComparisonOperator> get operators => widget.infoType.isDateType
      ? ComparisonOperator.values
      : [
          ComparisonOperator.contain,
          ComparisonOperator.equal,
          ComparisonOperator.notEqual,
        ];

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppNum.spaceSmall,
      children: [
        TextDropdown<InfoType>(
          items: InfoType.values
              .map(
                (e) => DropdownItem(
                  value: e,
                  key: ValueKey(e),
                  height: AppNum.widgetHeight,
                  child: BaseText(e.label),
                ),
              )
              .toList(),
          value: widget.infoType,
          width: widget.isEnglish ? 114 : 104,
          onChanged: widget.onInfoTypeChange,
        ),
        TextDropdown<ComparisonOperator>(
          items: operators
              .map(
                (e) => DropdownItem(
                  value: e,
                  key: ValueKey(e),
                  height: AppNum.widgetHeight,
                  child: BaseText(e.label),
                ),
              )
              .toList(),
          value: widget.operator,
          width: widget.isEnglish ? 130 : 104,
          onChanged: widget.onOperatorChange,
        ),
        SizedBox(
          width: 200,
          child: InputField(
            text: widget.value,
            hintText: tr(AppL10n.eRuleValue),
            onChanged: widget.onValueChange,
          ),
        ),
        SizedBox(
          width: 152,
          child: InputField(
            hintText: tr(AppL10n.dialogGroupHint),
            onChanged: widget.onGroupChange,
          ),
        ),
      ],
    );
  }
}
