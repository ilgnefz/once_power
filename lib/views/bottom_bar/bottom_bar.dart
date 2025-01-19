import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/bottom_bar/check_version.dart';
import 'package:once_power/views/bottom_bar/auto_run.dart';
import 'package:once_power/views/bottom_bar/regedit.dart';
import 'package:once_power/views/bottom_bar/repo_url.dart';
import 'package:once_power/views/bottom_bar/task_info.dart';

import 'enable_organize.dart';
import 'language_toggle.dart';
import 'log.dart';
import 'save.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
      ),
      child: Row(
        children: [
          const SaveBtn(),
          SizedBox(width: _smallG),
          if (Platform.isWindows) ...[
            const RegeditBtn(),
            SizedBox(width: _smallG),
          ],
          const AutoRunBtn(),
          SizedBox(width: _smallG),
          const LogBtn(),
          SizedBox(width: _smallG),
          const ViewModeBtn(),
          SizedBox(width: _smallG),
          const UploadCSVBtn(),
          SizedBox(width: _smallG),
          const EnableOrganizeBtn(),
          SizedBox(width: _mediumG),
          const LanguageToggleBtn(),
          SizedBox(width: _mediumG),
          const UndoBtn(),
          const Spacer(),
          const TaskInfo(),
          SizedBox(width: _mediumG),
          const RepoUrl(icon: AppIcons.gitee, url: AppText.gitee),
          SizedBox(width: _mediumG),
          const RepoUrl(icon: AppIcons.github, url: AppText.github),
          SizedBox(width: _mediumG),
          const CheckVersion(),
          SizedBox(width: _mediumG),
          Text(
            'v${PackageDesc.getVersion()}',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
