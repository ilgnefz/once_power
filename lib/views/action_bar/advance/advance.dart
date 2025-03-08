import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/advance/advance_directive_list.dart';
import 'package:once_power/views/action_bar/advance/advance_top_bar.dart';
import 'package:once_power/views/action_bar/advance/directive_group.dart';
import 'package:once_power/views/action_bar/advance/preset_btn.dart';
import 'package:once_power/views/action_bar/rename/add_folder_checkbox.dart';
import 'package:once_power/views/action_bar/rename/append_checkbox.dart';
import 'package:once_power/views/action_bar/rename/apply_rename_btn.dart';
import 'package:once_power/widgets/action_bar/add_file_group.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';

class AdvanceMenu extends StatelessWidget {
  const AdvanceMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdvanceTopBar(),
        Expanded(child: AdvanceDirectiveList()),
        DirectiveGroup(child: PresetBtn()),
        TwoCheckboxGroup(children: [AddFolderCheckbox(), AppendCheckbox()]),
        AddFolderGroup(child: ApplyRenameBtn()),
      ],
    );
  }
}
