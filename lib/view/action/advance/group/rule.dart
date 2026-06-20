import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/view/action/advance/group/rule_item.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/button.dart';

class RuleGroup extends ConsumerStatefulWidget {
  const RuleGroup({super.key, required this.file});

  final FileInfo file;

  @override
  ConsumerState<RuleGroup> createState() => _AutoGroupState();
}

class _AutoGroupState extends ConsumerState<RuleGroup> {
  List<GroupRule> list = [];

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale == LanguageType.english.locale;
    return EasyDialog(
      width: isEnglish ? 648 : 608,
      title: tr(AppL10n.menuRuleGroup),
      content: SingleChildScrollView(
        child: Column(
          spacing: AppNum.spaceSmall,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: list.map((e) {
            InfoType type = e.infoType;
            return GroupRuleItem(
              isEnglish: isEnglish,
              infoType: type,
              operator: e.operator,
              value: getRuleTypeValue(type, widget.file),
              onInfoTypeChange: (v) => setState(() => e.infoType = v!),
              onOperatorChange: (v) => setState(() => e.operator = v!),
              onValueChange: (v) => setState(() => e.value = v!),
              onGroupChange: (v) => setState(() => e.group = v!),
            );
          }).toList(),
        ),
      ),
      extraButton: EasyButton(
        label: tr(AppL10n.menuRule),
        onPressed: () {
          setState(() {
            final InfoType type = InfoType.values.first;
            list.add(
              GroupRule(
                infoType: type,
                value: getRuleTypeValue(type, widget.file),
              ),
            );
          });
        },
      ),
      onOk: () => ruleGroupFile(ref, list),
    );
  }
}
