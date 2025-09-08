import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/add_group.dart';
import 'package:once_power/views/action/apply.dart';
import 'package:once_power/views/action/apply_group.dart';
import 'package:once_power/views/action/rename/date.dart';
import 'package:once_power/views/action/rename/ext.dart';
import 'package:once_power/views/action/rename/match.dart';
import 'package:once_power/views/action/rename/modify.dart';
import 'package:once_power/views/action/rename/prefix.dart';
import 'package:once_power/views/action/rename/prefix_serial.dart';
import 'package:once_power/views/action/rename/suffix.dart';
import 'package:once_power/views/action/rename/suffix_serial.dart';
import 'package:once_power/widgets/action/action_structure.dart';

import 'case_group.dart';

class RenameMenu extends StatefulWidget {
  const RenameMenu({super.key, required this.slot});

  final Widget slot;

  @override
  State<RenameMenu> createState() => _RenameMenuState();
}

class _RenameMenuState extends State<RenameMenu>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ActionStructure(
      menus: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppNum.paddingMedium,
          horizontal: AppNum.padding,
        ),
        child: Column(
          spacing: AppNum.spaceMedium,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MatchInput(),
            widget.slot,
            ModifyGroup(),
            DateInput(),
            PrefixInput(),
            PrefixSerial(),
            SuffixInput(),
            SuffixSerial(),
            ExtInput(),
          ],
        ),
      ),
      actions: const [
        CaseGroup(),
        AddGroup(),
        SizedBox(height: AppNum.spaceMedium),
        ApplyGroup(slot: ApplyRename()),
        SizedBox(height: AppNum.spaceMedium),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
