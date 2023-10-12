import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import 'check_version.dart';
import 'enable_organize.dart';
import 'repo_url.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String download = '下载';
    const String openSave = '已开启保存配置';
    const String closeSave = '未开启保存配置';
    const String giteeUrl = 'https://gitee.com/ilgnefz/once_power';
    const String githubUrl = 'https://github.com/ilgnefz/once_power';
    const TextStyle style = TextStyle(fontSize: 13, color: Colors.grey);
    bool save = ref.watch(saveConfigProvider);

    void downloadWeb() async {
      String url = 'https://gitee.com/ilgnefz/once_power/releases';
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
          EasyTooltip(
            message: save ? openSave : closeSave,
            child: ClickIcon(
              size: 24,
              svg: AppIcons.save,
              color: save ? Theme.of(context).primaryColor : Colors.grey,
              onTap: ref.read(saveConfigProvider.notifier).update,
            ),
          ),
          const SizedBox(width: 4),
          const EnableOrganize(),
          const Spacer(),
          const RepoUrl(icon: AppIcons.gitee, url: giteeUrl),
          const SizedBox(width: 12),
          const RepoUrl(icon: AppIcons.github, url: githubUrl),
          const CheckVersion(),
          if (ref.watch(newVersionProvider)) ...[
            InkWell(
              onTap: downloadWeb,
              child: const Text(
                download,
                style: TextStyle(fontSize: 13, color: Colors.blue),
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
