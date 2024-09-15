import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';

import 'download_button.dart';
import 'log_button.dart';
import 'undo_button.dart';
import 'upload_csv.dart';
import 'view_mode_button.dart';
import 'language_toggle.dart';
import 'save_button.dart';
import 'check_version.dart';
import 'enable_organize_checkbox.dart';
import 'repo_url.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentTask = S.of(context).currentTask;
    final String takeTime = S.of(context).takeTime;

    const String giteeUrl = 'https://gitee.com/ilgnefz/once_power';
    const String githubUrl = 'https://github.com/ilgnefz/once_power';
    const TextStyle style = TextStyle(fontSize: 13, color: Colors.grey);

    int count = ref.watch(countProvider);
    int total = ref.watch(totalProvider);
    String cost = ref.watch(costProvider).toStringAsFixed(2);

    return Container(
      height: AppNum.bottomBarH,
      padding: const EdgeInsets.symmetric(horizontal: AppNum.bottomBarP),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
      ),
      child: Row(
        children: [
          const SaveButton(),
          const SizedBox(width: AppNum.bottomBtnInterval),
          // const LogButton(),
          // const SizedBox(width: AppNum.bottomBtnInterval),
          const ViewModeButton(),
          const SizedBox(width: AppNum.bottomBtnInterval),
          const UploadCSV(),
          const SizedBox(width: AppNum.bottomBtnInterval),
          const EnableOrganizeCheckbox(),
          const SizedBox(width: AppNum.bottomBtnInterval - 4),
          const LanguageToggle(),
          const SizedBox(width: AppNum.bottomBtnInterval - 4),
          const UndoButton(),
          const Spacer(),
          Text(
            '$currentTask: $count/$total  $takeTime: ${cost}s',
            style: style,
          ),
          const SizedBox(width: AppNum.bottomBarInterval),
          const RepoUrl(icon: AppIcons.gitee, url: giteeUrl),
          const SizedBox(width: AppNum.bottomBarInterval),
          const RepoUrl(icon: AppIcons.github, url: githubUrl),
          const CheckVersion(),
          if (ref.watch(newVersionProvider)) const DownloadTextButton(),
          Text('v${PackageDesc.getVersion()}', style: style),
        ],
      ),
    );
  }
}
