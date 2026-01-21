import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/view/bottom/save.dart';
import 'package:once_power/view/bottom/task.dart';
import 'package:once_power/view/bottom/theme.dart';
import 'package:once_power/view/bottom/view.dart';

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: AppNum.bottomBar,
      padding: EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.padding,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: theme.dividerColor)),
      ),
      child: Row(
        spacing: AppNum.spaceMedium,
        children: [
          SaveButton(),
          ViewButton(),
          ThemeButton(),
          Spacer(),
          TaskMsg(),
        ],
      ),
    );
  }
}
