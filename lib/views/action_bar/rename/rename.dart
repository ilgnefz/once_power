import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/additional_options.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/apply_menu.dart';

import 'package:once_power/widgets/action_bar/view_structure.dart';

import 'operation_menu/date_input.dart';
import 'operation_menu/differ_menu.dart';
import 'operation_menu/extension_input.dart';
import 'operation_menu/match_input.dart';
import 'operation_menu/modify_input.dart';
import 'operation_menu/prefix_input.dart';
import 'operation_menu/prefix_num_input.dart';
import 'operation_menu/suffix_input.dart';
import 'operation_menu/suffix_num_input.dart';

class RenameAction extends StatelessWidget {
  const RenameAction({super.key});

  @override
  Widget build(BuildContext context) {
    const double gap = AppNum.mediumG;

    return const ViewStructure(
      topAction: SingleChildScrollView(
        child: Column(
          children: [
            MatchInput(),
            SizedBox(height: gap),
            DifferMenu(),
            SizedBox(height: gap),
            ModifyInput(),
            SizedBox(height: gap),
            DateInput(),
            SizedBox(height: gap),
            PrefixInput(),
            SizedBox(height: gap),
            PrefixNumInput(),
            SizedBox(height: gap),
            SuffixInput(),
            SizedBox(height: gap),
            SuffixNumInput(),
            SizedBox(height: gap),
            ExtensionInput(),
          ],
        ),
      ),
      bottomActions: [
        AdditionalOptions(),
        SizedBox(height: gap),
        ApplyMenu(),
      ],
    );
  }
}
