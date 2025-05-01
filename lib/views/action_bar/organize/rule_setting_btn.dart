import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';
import 'package:once_power/widgets/action_bar/folder_input.dart';

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

class EasyChild extends StatelessWidget {
  const EasyChild({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppNum.inputP, vertical: AppNum.smallG),
      child: Row(
        children: [
          Text('$title:'),
          Expanded(child: FolderInput()),
        ],
      ),
    );
  }
}
