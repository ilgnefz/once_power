import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/add_group.dart';
import 'package:once_power/views/action/apply_group.dart';
import 'package:once_power/views/action/organize/apply.dart';
import 'package:once_power/views/action/organize/delete.dart';
import 'package:once_power/views/action/organize/group.dart';
import 'package:once_power/views/action/organize/instructions.dart';
import 'package:once_power/views/action/organize/other.dart';
import 'package:once_power/views/action/organize/target.dart';
import 'package:once_power/views/action/organize/type.dart';

class OrganizeView extends StatelessWidget {
  const OrganizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Instructions()),
        SizedBox(height: AppNum.spaceMedium),
        TargetInput(),
        SizedBox(height: AppNum.spaceMedium),
        GroupGroup(),
        SizedBox(height: AppNum.spaceMedium),
        TypeGroup(),
        SizedBox(height: AppNum.spaceMedium),
        OtherGroup(),
        AddGroup(),
        SizedBox(height: AppNum.spaceMedium),
        DeleteGroup(),
        SizedBox(height: AppNum.spaceMedium),
        ApplyGroup(slot: ApplyOrganize()),
        SizedBox(height: AppNum.spaceMedium),
      ],
    );
  }
}
