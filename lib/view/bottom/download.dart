import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/bottom_text.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/widget/bottom/text.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadTextButton extends ConsumerWidget {
  const DownloadTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void downloadWeb() async {
      // LanguageType type = context.locale.languageCode == 'zh'
      //     ? LanguageType.chinese
      //     : LanguageType.english;
      // String url = AppText.giteeDownload;
      // if (type == LanguageType.english) url = AppText.githubDownload;
      await launchUrl(Uri.parse(AppText.githubDownload));
    }

    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: downloadWeb,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Text(
        tr(AppL10n.bottomDownload),
        style: Theme.of(
          context,
        ).extension<BottomTextTheme>()!.textStyle.copyWith(color: Colors.blue),
      ),
    );
  }
}
