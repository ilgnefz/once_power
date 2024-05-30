import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadTextButton extends ConsumerWidget {
  const DownloadTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String download = S.of(context).download;

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
      margin: const EdgeInsets.only(right: 16),
      alignment: Alignment.center,
      child: InkWell(
        onTap: downloadWeb,
        child: Text(
          download,
          style: const TextStyle(fontSize: 13, color: Colors.blue),
        ),
      ),
    );
  }
}
