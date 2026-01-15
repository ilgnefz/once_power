import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/rule.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/views/action/advance/dialog/common_dialog.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/easy_btn.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class AutoGroup extends ConsumerStatefulWidget {
  const AutoGroup({super.key, required this.file});

  final FileInfo file;

  @override
  ConsumerState<AutoGroup> createState() => _AutoGroupState();
}

class _AutoGroupState extends ConsumerState<AutoGroup> {
  List<GroupRule> list = [];

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale == LanguageType.english.locale;
    return CommonDialog(
      title: tr(AppL10n.menuAutoGroup),
      width: isEnglish ? 648 : 608,
      extraButton: EasyBtn(
          label: tr(AppL10n.menuRule),
          onPressed: () {
            setState(() {
              final InfoType type = InfoType.values.first;
              list.add(GroupRule(
                infoType: type,
                operator: ComparisonOperator.contain,
                value: getRuleTypeValue(type, widget.file),
                group: '',
              ));
            });
          }),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppNum.spaceSmall,
          children: list.map((e) {
            InfoType type = e.infoType;
            return GroupRuleItem(
              isEnglish: isEnglish,
              infoType: type,
              operator: e.operator,
              value: getRuleTypeValue(type, widget.file),
              group: e.group,
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
              onGroupChange: (v) {
                setState(() {
                  e.group = v!;
                });
              },
            );
          }).toList(),
        ),
      ),
      onOk: () async => await autoGroupFile(ref, list),
    );
  }
}

class GroupRuleItem extends StatefulWidget {
  const GroupRuleItem({
    super.key,
    required this.isEnglish,
    required this.infoType,
    required this.operator,
    required this.value,
    required this.group,
    required this.onInfoTypeChange,
    required this.onOperatorChange,
    required this.onValueChange,
    required this.onGroupChange,
  });

  final bool isEnglish;
  final InfoType infoType;
  final ComparisonOperator operator;
  final String value;
  final String group;
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
        SizedBox(
          width: 148,
          child: BaseInput(
            hintText: tr(AppL10n.dialogGroupHint),
            onChanged: widget.onGroupChange,
          ),
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
      // 延迟到下一帧执行，避免build阶段冲突
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onValueChange(_controller.text);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RuleInput oldWidget) {
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 208,
      child: BaseInput(
        hintText: tr(AppL10n.eRuleValue),
        controller: _controller,
        onChanged: widget.onValueChange,
      ),
    );
  }
}
