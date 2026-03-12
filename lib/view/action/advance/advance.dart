import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/view/action/add.dart';
import 'package:once_power/view/action/advance/directive/list.dart';
import 'package:once_power/view/action/advance/operate.dart';
import 'package:once_power/view/action/advance/top.dart';
import 'package:once_power/view/action/apply.dart';
import 'package:once_power/view/action/picker.dart';

final Widget _space = SizedBox(height: AppNum.spaceMedium);

class AdvanceView extends StatelessWidget {
  const AdvanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdvanceTop(),
        Expanded(child: DirectiveList()),
        _space,
        OperateGroup(),
        _space,
        AddGroup(),
        _space,
        FilePickerGroup(slot: ApplyButton()),
        _space,
      ],
    );
  }
}
