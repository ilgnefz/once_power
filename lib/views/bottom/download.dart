import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/enums/app.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadTextBtn extends ConsumerWidget {
  const DownloadTextBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void downloadWeb() async {
      LanguageType type = context.locale.languageCode == 'zh'
          ? LanguageType.chinese
          : LanguageType.english;
      String url = AppString.giteeDownload;
      if (type == LanguageType.english) url = AppString.githubDownload;
      await launchUrl(Uri.parse(url));
    }

    return Container(
      height: AppNum.bottom,
      alignment: Alignment.center,
      child: InkWell(
        onTap: downloadWeb,
        child: Text(
          tr(AppL10n.bottomDownload),
          style: TextStyle(
            fontSize: 13,
            color: Colors.blue,
            fontFamily: defaultFont,
          ),
        ),
      ),
    );
  }
}
