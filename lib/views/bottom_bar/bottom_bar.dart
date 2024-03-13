import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/bottom_bar/language_toggle.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import 'check_version.dart';
import 'enable_organize.dart';
import 'repo_url.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String download = S.of(context).download;
    final String openSave = S.of(context).enableSaveConfig;
    final String closeSave = S.of(context).closeSaveConfig;
    final String currentTask = S.of(context).currentTask;
    final String takeTime = S.of(context).takeTime;
    const String giteeUrl = 'https://gitee.com/ilgnefz/once_power';
    const String githubUrl = 'https://github.com/ilgnefz/once_power';
    const TextStyle style = TextStyle(fontSize: 13, color: Colors.grey);
    bool save = ref.watch(saveConfigProvider);

    int count = ref.watch(countProvider);
    int total = ref.watch(totalProvider);
    String cost = ref.watch(costProvider).toStringAsFixed(2);

    void downloadWeb() async {
      LanguageType type = ref.watch(currentLanguageProvider);
      String url = '';
      if (type == LanguageType.english) {
        url = 'https://github.com/ilgnefz/once_power/releases';
      } else {
        url = 'https://gitee.com/ilgnefz/once_power/releases';
      }
      await launchUrl(Uri.parse(url));
    }

    return Container(
      height: AppNum.bottomBarH,
      padding: const EdgeInsets.symmetric(horizontal: AppNum.bottomBarP),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
      ),
      child: Row(
        children: [
          CustomTooltip(
            content: Text(
              save ? openSave : closeSave,
              style: const TextStyle(fontSize: 13),
            ),
            child: ClickIcon(
              size: 24,
              svg: AppIcons.save,
              color: save ? Theme.of(context).primaryColor : Colors.grey,
              onTap: ref.read(saveConfigProvider.notifier).update,
            ),
          ),
          const SizedBox(width: 4),
          const EnableOrganize(),
          const SizedBox(width: 4),
          const LanguageToggle(),
          const Spacer(),
          Text(
            '$currentTask: $count/$total  $takeTime: ${cost}s',
            style: style,
          ),
          const SizedBox(width: 12),
          const RepoUrl(icon: AppIcons.gitee, url: giteeUrl),
          const SizedBox(width: 12),
          const RepoUrl(icon: AppIcons.github, url: githubUrl),
          const CheckVersion(),
          if (ref.watch(newVersionProvider)) ...[
            InkWell(
              onTap: downloadWeb,
              child: Text(
                download,
                style: const TextStyle(fontSize: 13, color: Colors.blue),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Text('v${PackageDesc.getVersion()}', style: style),
        ],
      ),
    );
  }
}
