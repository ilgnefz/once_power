import 'package:flutter/material.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/views/bottom/auto_run.dart';
import 'package:once_power/views/bottom/check.dart';
import 'package:once_power/views/bottom/date.dart';
import 'package:once_power/views/bottom/log.dart';
import 'package:once_power/views/bottom/task_msg.dart';
import 'package:once_power/views/bottom/tip.dart';
import 'package:once_power/views/bottom/version.dart';
import 'package:once_power/views/bottom/view.dart';

import 'csv.dart';
import 'language.dart';
import 'regedit.dart';
import 'repo_url.dart';
import 'save.dart';
import 'theme.dart';

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.bottom,
      padding: const EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.padding,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Row(
        spacing: AppNum.spaceSmall,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SaveBtn(),
          RegeditBtn(),
          AutoRunBtn(),
          LogBtn(),
          ViewBtn(),
          CSVBtn(),
          DateModifyBtn(),
          TipBtn(),
          ThemeSwitch(),
          LanguageSwitch(),
          Spacer(),
          TaskMsg(),
          SizedBox(width: 2),
          RepoUrl(icon: AppIcons.gitee, url: AppString.gitee),
          SizedBox(width: 2),
          RepoUrl(icon: AppIcons.github, url: AppString.github),
          SizedBox(width: 2),
          CheckBtn(),
          SizedBox(width: 2),
          VersionText(),
        ],
      ),
    );
  }
}
