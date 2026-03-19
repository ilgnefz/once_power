import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/view/action/add.dart';
import 'package:once_power/view/action/organize/apply.dart';
import 'package:once_power/view/action/organize/date.dart';
import 'package:once_power/view/action/organize/delete.dart';
import 'package:once_power/view/action/organize/group.dart';
import 'package:once_power/view/action/organize/other.dart';
import 'package:once_power/view/action/organize/target.dart';
import 'package:once_power/view/action/organize/type.dart';
import 'package:once_power/view/action/picker.dart';

import 'instructions.dart';

final Widget _space = SizedBox(height: AppNum.spaceMedium);

class OrganizeView extends StatefulWidget {
  const OrganizeView({super.key});

  @override
  State<OrganizeView> createState() => _OrganizeViewState();
}

class _OrganizeViewState extends State<OrganizeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(child: Instructions()),
        _space,
        TargetInput(),
        _space,
        GroupGroup(),
        _space,
        TypeGroup(),
        _space,
        OtherGroup(),
        SizedBox(height: AppNum.spaceSmall),
        DateOptions(),
        AddGroup(),
        _space,
        DeleteGroup(),
        _space,
        FilePickerGroup(slot: ApplyOrganize()),
        _space,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
