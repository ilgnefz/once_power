import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/bottom_bar/check_version.dart';
import 'package:once_power/views/bottom_bar/enable_organize.dart';
import 'package:once_power/views/bottom_bar/repo_url.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const TextStyle style = TextStyle(fontSize: 13, color: Colors.grey);
    bool save = ref.watch(saveConfigProvider);

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
            message: save ? '已开启保存配置' : '未开启保存配置',
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
          const RepoUrl(
            icon: AppIcons.gitee,
            url: 'https://gitee.com/ilgnefz/once_power',
          ),
          const SizedBox(width: 12),
          const RepoUrl(
            icon: AppIcons.github,
            url: 'https://github.com/ilgnefz/once_power',
          ),
          const CheckVersion(),
          if (ref.watch(newVersionProvider)) ...[
            InkWell(
              onTap: () async {
                String url = 'https://gitee.com/ilgnefz/once_power/releases';
                await launchUrl(Uri.parse(url));
              },
              child: const Text(
                '下载',
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
