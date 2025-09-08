import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/theme.dart';
import 'package:once_power/views/bottom/auto_run.dart';
import 'package:once_power/views/bottom/check.dart';
import 'package:once_power/views/bottom/date.dart';
import 'package:once_power/views/bottom/log.dart';
import 'package:once_power/views/bottom/task_msg.dart';
import 'package:once_power/views/bottom/tip.dart';
import 'package:once_power/views/bottom/undo.dart';
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
    return Consumer(
      builder: (_, ref, child) {
        return AbsorbPointer(
          absorbing: ref.watch(isApplyingProvider),
          child: Container(
            height: AppNum.bottom,
            padding: const EdgeInsets.only(
              left: AppNum.paddingMedium,
              right: AppNum.padding,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(
                    alpha: ref.watch(transparentDividerProvider) ? 0 : 1,
                  ),
                  width: 1,
                ),
              ),
            ),
            child: child,
          ),
        );
      },
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
          UndoBtn(),
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
