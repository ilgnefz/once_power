import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/add_group.dart';
import 'package:once_power/views/action/advance/directives.dart';
import 'package:once_power/views/action/advance/operate.dart';
import 'package:once_power/views/action/advance/top.dart';
import 'package:once_power/views/action/apply.dart';
import 'package:once_power/views/action/apply_group.dart';

class AdvanceView extends StatelessWidget {
  const AdvanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AdvanceTop(),
        DirectiveList(),
        SizedBox(height: AppNum.spaceMedium),
        OperateGroup(),
        SizedBox(height: AppNum.spaceMedium),
        AddGroup(),
        SizedBox(height: AppNum.spaceMedium),
        ApplyGroup(slot: ApplyRename()),
        SizedBox(height: AppNum.spaceMedium),
      ],
    );
  }
}
