import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/utils/pack_info.dart';
import 'package:once_power/views/bottom_bar/check_version.dart';
import 'package:once_power/views/bottom_bar/tip.dart';

import 'auto_run.dart';
import 'language_toggle.dart';
import 'log.dart';
import 'regedit.dart';
import 'repo_url.dart';
import 'save.dart';
import 'task_info.dart';
import 'undo.dart';
import 'upload_csv.dart';
import 'view_mode.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  final double _smallG = AppNum.smallG;
  final double _mediumG = AppNum.mediumG;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.bottomBarH,
      padding: const EdgeInsets.only(
          left: AppNum.defaultP - 4, right: AppNum.defaultP),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: _smallG,
        children: [
          SaveBtn(),
          if (Platform.isWindows) RegeditBtn(),
          AutoRunBtn(),
          LogBtn(),
          ViewModeBtn(),
          UploadCSVBtn(),
          TipBtn(),
          // ExtraFunctionBtn(),
          LanguageToggleBtn(),
          UndoBtn(),
          Spacer(),
          Row(
            spacing: _mediumG,
            children: [
              TaskInfo(),
              const RepoUrl(icon: AppIcons.gitee, url: AppText.gitee),
              const RepoUrl(icon: AppIcons.github, url: AppText.github),
              CheckVersion(),
              Text(
                'v${PackInfo.getVersion()}',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
