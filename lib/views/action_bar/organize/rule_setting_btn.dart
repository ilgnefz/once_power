import 'package:flutter/material.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';

class RuleSettingBtn extends StatelessWidget {
  const RuleSettingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyBtn(
      S.of(context).classifyType,
      height: 30,
      onTap: () => showAllRule(context),
    );
  }
}
