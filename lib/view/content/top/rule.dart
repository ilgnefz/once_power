import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/button.dart';
import 'package:once_power/widget/common/input_field.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

class RuleFilter extends ConsumerStatefulWidget {
  const RuleFilter({super.key});

  @override
  ConsumerState<RuleFilter> createState() => _RuleFilterState();
}

class _RuleFilterState extends ConsumerState<RuleFilter> {
  List<FilterRule> list = [];

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale == LanguageType.english.locale;
    return EasyDialog(
      title: tr(AppL10n.contentFilterRule),
      width: isEnglish ? 604 : 564,
      padding: .zero,
      content: SingleChildScrollView(
        padding: .symmetric(horizontal: AppNum.padding),
        child: Column(
          spacing: AppNum.spaceSmall,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: list.map((e) {
            InfoType type = e.infoType;
            return FilterRuleItem(
              isEnglish: isEnglish,
              infoType: type,
              operator: e.operator,
              value: e.value,
              action: e.action,
              onInfoTypeChange: (v) => setState(() => e.infoType = v!),
              onOperatorChange: (v) => setState(() => e.operator = v!),
              onValueChange: (v) => setState(() => e.value = v!),
              onActionChange: (v) => setState(() => e.action = v!),
            );
          }).toList(),
        ),
      ),
      extraButton: EasyButton(
        label: tr(AppL10n.menuRule),
        onPressed: () => setState(() {
          final InfoType type = InfoType.values.first;
          list.add(
            FilterRule(
              infoType: type,
              operator: ComparisonOperator.contain,
              value: '',
              action: ActionType.remove,
            ),
          );
        }),
      ),
      onOk: () async {
        if (list.isEmpty) return;
        List<FileInfo> files = ref.watch(fileListProvider);
        for (FilterRule item in list) {
          InfoType type = item.infoType;
          ComparisonOperator operator = item.operator;
          String value = item.value;
          ActionType action = item.action;
          for (FileInfo file in files) {
            String info = getRuleTypeValue(type, file);
            if (getCompareResult(operator, value, info)) {
              if (action.isRemove) {
                ref.read(fileListProvider.notifier).remove(file);
              } else {
                ref
                    .read(fileListProvider.notifier)
                    .updateCheck(file.id, action.isSelect);
              }
            }
          }
        }
        updateName(ref);
      },
    );
  }
}

class FilterRuleItem extends StatefulWidget {
  const FilterRuleItem({
    super.key,
    required this.isEnglish,
    required this.infoType,
    required this.operator,
    required this.value,
    required this.action,
    required this.onInfoTypeChange,
    required this.onOperatorChange,
    required this.onValueChange,
    required this.onActionChange,
  });

  final bool isEnglish;
  final InfoType infoType;
  final ComparisonOperator operator;
  final String value;
  final ActionType action;
  final void Function(InfoType?) onInfoTypeChange;
  final void Function(ComparisonOperator?) onOperatorChange;
  final void Function(String?) onValueChange;
  final void Function(ActionType?) onActionChange;

  @override
  State<FilterRuleItem> createState() => _FilterRuleItemState();
}

class _FilterRuleItemState extends State<FilterRuleItem> {
  List<ComparisonOperator> get operators => widget.infoType.isDateType
      ? ComparisonOperator.values
      : [
          ComparisonOperator.contain,
          ComparisonOperator.notContain,
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
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          width: widget.isEnglish ? 114 : 104,
          value: widget.infoType,
          onChanged: widget.onInfoTypeChange,
        ),
        TextDropdown<ComparisonOperator>(
          items: operators
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: widget.operator,
          width: widget.isEnglish ? 130 : 104,
          onChanged: widget.onOperatorChange,
        ),
        SizedBox(
          width: 208,
          child: InputField(
            text: widget.value,
            hintText: tr(AppL10n.eRuleValue),
            onChanged: widget.onValueChange,
          ),
        ),
        TextDropdown<ActionType>(
          items: ActionType.values
              .map(
                (e) => DropdownItem(
                  value: e,
                  key: ValueKey(e),
                  height: AppNum.widgetHeight,
                  child: BaseText(e.label),
                ),
              )
              .toList(),
          width: 102,
          value: widget.action,
          onChanged: widget.onActionChange,
        ),
      ],
    );
  }
}
