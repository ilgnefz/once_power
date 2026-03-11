import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/view/bottom/auto_run.dart';
import 'package:once_power/view/bottom/csv.dart';
import 'package:once_power/view/bottom/date.dart';
import 'package:once_power/view/bottom/language.dart';
import 'package:once_power/view/bottom/log.dart';
import 'package:once_power/view/bottom/regedit.dart';
import 'package:once_power/view/bottom/save.dart';
import 'package:once_power/view/bottom/setting.dart';
import 'package:once_power/view/bottom/task.dart';
import 'package:once_power/view/bottom/theme.dart';
import 'package:once_power/view/bottom/tip.dart';
import 'package:once_power/view/bottom/undo.dart';
import 'package:once_power/view/bottom/version.dart';
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
        spacing: AppNum.spaceSmall,
        children: [
          SaveButton(),
          RegeditButton(),
          AutoRunButton(),
          LogButton(),
          ViewButton(),
          CSVButton(),
          DateButton(),
          ThemeButton(),
          TipButton(),
          SettingButton(),
          LanguageButton(),
          UndoButton(),
          Spacer(),
          TaskMessage(),
          VersionText(),
        ],
      ),
    );
  }
}
