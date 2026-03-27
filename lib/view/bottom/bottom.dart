import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/provider/setting.dart';
import 'package:once_power/view/bottom/auto_run.dart';
import 'package:once_power/view/bottom/check.dart';
import 'package:once_power/view/bottom/csv.dart';
import 'package:once_power/view/bottom/date.dart';
import 'package:once_power/view/bottom/language.dart';
import 'package:once_power/view/bottom/log.dart';
import 'package:once_power/view/bottom/regedit.dart';
import 'package:once_power/view/bottom/save.dart';
import 'package:once_power/view/bottom/setting/setting.dart';
import 'package:once_power/view/bottom/task.dart';
import 'package:once_power/view/bottom/theme.dart';
import 'package:once_power/view/bottom/undo.dart';
import 'package:once_power/view/bottom/version.dart';
import 'package:once_power/view/bottom/view.dart';

import 'repo_url.dart';

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Container(
          height: AppNum.bottomBar,
          padding: EdgeInsets.only(
            left: AppNum.paddingMedium,
            right: AppNum.padding,
          ),
          decoration: BoxDecoration(
            border: ref.watch(themeSettingProvider.select((e) => e.divider))
                ? null
                : Border(top: BorderSide(width: 1, color: theme.dividerColor)),
          ),
          child: child,
        );
      },
      child: Row(
        spacing: AppNum.spaceSmall,
        children: [
          SaveButton(),
          if (Platform.isWindows) ...[RegeditButton(),
          AutoRunButton()],
          LogButton(),
          ViewButton(),
          CSVButton(),
          DateButton(),
          ThemeButton(),
          SettingButton(),
          LanguageButton(),
          UndoButton(),
          Spacer(),
          TaskMessage(),
          SizedBox(width: AppNum.spaceSmall),
          RepoUrl(icon: AppIcons.gitee, url: AppText.gitee),
          SizedBox(width: 2),
          RepoUrl(icon: AppIcons.github, url: AppText.github),
          SizedBox(width: AppNum.spaceSmall),
          CheckVersionButton(),
          SizedBox(width: AppNum.spaceSmall),
          VersionText(),
        ],
      ),
    );
  }
}
