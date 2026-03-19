import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/view/action/add.dart';
import 'package:once_power/view/action/advance/directive/list.dart';
import 'package:once_power/view/action/advance/operate.dart';
import 'package:once_power/view/action/advance/top.dart';
import 'package:once_power/view/action/apply.dart';
import 'package:once_power/view/action/picker.dart';

final Widget _space = SizedBox(height: AppNum.spaceMedium);

class AdvanceView extends StatefulWidget {
  const AdvanceView({super.key});

  @override
  State<AdvanceView> createState() => _AdvanceViewState();
}

class _AdvanceViewState extends State<AdvanceView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return GestureDetector(
          onTap: () =>
              ref.read(advanceMenuSelectedListProvider.notifier).clear(),
          child: child,
        );
      },
      child: Column(
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
