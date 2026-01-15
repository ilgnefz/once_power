import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/enums/rule.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/rule.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/views/action/advance/dialog/common_dialog.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/easy_btn.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class RuleFilter extends ConsumerStatefulWidget {
  const RuleFilter({super.key});

  @override
  ConsumerState<RuleFilter> createState() => _RuleFilterState();
}

class _RuleFilterState extends ConsumerState<RuleFilter> {
  List<FilterRule> list = [];

  void onOk() async {
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
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale == LanguageType.english.locale;
    return CommonDialog(
      title: tr(AppL10n.contentFilterRule),
      width: isEnglish ? 604 : 564,
      extraButton: EasyBtn(
          label: tr(AppL10n.menuRule),
          onPressed: () {
            setState(() {
              final InfoType type = InfoType.values.first;
              list.add(FilterRule(
                infoType: type,
                operator: ComparisonOperator.contain,
                value: '',
                action: ActionType.remove,
              ));
            });
          }),
      onOk: onOk,
      child: SingleChildScrollView(
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
              onInfoTypeChange: (v) {
                setState(() {
                  e.infoType = v!;
                });
              },
              onOperatorChange: (v) {
                setState(() {
                  e.operator = v!;
                });
              },
              onValueChange: (v) {
                setState(() {
                  e.value = v!;
                });
              },
              onActionChange: (v) {
                setState(() {
                  e.action = v!;
                });
              },
            );
          }).toList(),
        ),
      ),
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
          ComparisonOperator.equal,
          ComparisonOperator.notEqual,
        ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;
    return Row(
      spacing: AppNum.spaceSmall,
      children: [
        TextDropdown(
          items: InfoType.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          color: theme.popupMenuTheme.surfaceTintColor,
          width: widget.isEnglish ? 114 : 104,
          value: widget.infoType,
          onChanged: widget.onInfoTypeChange,
        ),
        TextDropdown(
          items: operators
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          color: theme.popupMenuTheme.surfaceTintColor,
          value: widget.operator,
          width: widget.isEnglish ? 130 : 104,
          onChanged: widget.onOperatorChange,
        ),
        RuleInput(value: widget.value, onValueChange: widget.onValueChange),
        TextDropdown(
          items: ActionType.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          color: theme.popupMenuTheme.surfaceTintColor,
          width: 102,
          value: widget.action,
          onChanged: widget.onActionChange,
        ),
      ],
    );
  }
}

class RuleInput extends StatefulWidget {
  const RuleInput({
    super.key,
    required this.value,
    required this.onValueChange,
  });

  final String value;
  final void Function(String?) onValueChange;

  @override
  State<RuleInput> createState() => _RuleInputState();
}

class _RuleInputState extends State<RuleInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.addListener(() {
      widget.onValueChange(_controller.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 208,
      child: BaseInput(
        hintText: tr(AppL10n.eRuleValue),
        controller: _controller,
        show: _controller.text.isNotEmpty,
        onClear: _controller.clear,
        onChanged: widget.onValueChange,
      ),
    );
  }
}
