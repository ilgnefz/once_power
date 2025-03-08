import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/action_bar/add_file_group.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';
import 'package:once_power/widgets/action_bar/view_structure.dart';

import 'add_folder_checkbox.dart';
import 'append_checkbox.dart';
import 'apply_rename_btn.dart';
import 'case_extension_checkbox.dart';
import 'case_file_checkbox.dart';
import 'date_input.dart';
import 'extension_input.dart';
import 'match_input.dart';
import 'modify_input.dart';
import 'prefix_input.dart';
import 'prefix_serial.dart';
import 'suffix_input.dart';
import 'suffix_serial.dart';

class RenameMenu extends StatelessWidget {
  const RenameMenu({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ViewStructure(
      operateList: [
        MatchInput(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
          child: child,
        ),
        ModifyInput(),
        DateInput(),
        PrefixInput(),
        PrefixSerial(),
        SuffixInput(),
        SuffixSerial(),
        ExtensionInput(),
      ],
      bottomAction: [
        TwoCheckboxGroup(
          children: [CaseFileCheckbox(), CaseExtensionCheckbox()],
        ),
        TwoCheckboxGroup(children: [AddFolderCheckbox(), AppendCheckbox()]),
        AddFolderGroup(child: ApplyRenameBtn()),
      ],
    );
  }
}
