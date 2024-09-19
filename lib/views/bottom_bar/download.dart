import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadTextBtn extends ConsumerWidget {
  const DownloadTextBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String download = S.of(context).download;

    void downloadWeb() async {
      LanguageType type = ref.watch(currentLanguageProvider);
      String url = AppText.giteeDownload;
      if (type == LanguageType.english) url = AppText.githubDownload;
      await launchUrl(Uri.parse(url));
    }

    return Container(
      height: AppNum.bottomBarH,
      alignment: Alignment.center,
      child: InkWell(
        onTap: downloadWeb,
        child: Text(
          download,
          style: const TextStyle(fontSize: 13, color: Colors.blue)
              .useSystemChineseFont(),
        ),
      ),
    );
  }
}
