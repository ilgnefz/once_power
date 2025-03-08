import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action_bar/organize/instructions_text.dart';
import 'package:once_power/views/action_bar/organize/target_folder_input.dart';
import 'package:once_power/views/action_bar/organize/top_parents_checkbox.dart';
import 'package:once_power/views/action_bar/rename/add_folder_checkbox.dart';
import 'package:once_power/views/action_bar/rename/append_checkbox.dart';
import 'package:once_power/widgets/action_bar/add_file_group.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';

import 'apply_organize_btn.dart';
import 'classify_file_checkbox.dart';
import 'delete_empty_btn.dart';
import 'delete_selected_btn.dart';
import 'open_rule_checkbox.dart';
import 'rule_setting_btn.dart';

class OrganizeMenu extends StatelessWidget {
  const OrganizeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppNum.smallG,
      children: [
        Expanded(child: SingleChildScrollView(child: InstructionsText())),
        SizedBox(height: AppNum.smallG / 2),
        TargetFolderInput(),
        TwoCheckboxGroup(
          left: AppNum.defaultP,
          children: [RuleSettingBtn(), OpenRuleCheckbox()],
        ),
        TwoCheckboxGroup(
          children: [TimeClassifyCheckbox(), TopParentsCheckbox()],
        ),
        TwoCheckboxGroup(children: [AddFolderCheckbox(), AppendCheckbox()]),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [DeleteSelectedBtn(), DeleteEmptyBtn()],
          ),
        ),
        AddFolderGroup(child: ApplyOrganizeBtn()),
      ],
    );
  }
}
