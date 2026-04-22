import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/widget/common/click_text.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        EasyClickText(
          label: tr(AppL10n.settingTutorial),
          onPressed: () async {
            String url = context.locale == LanguageType.chinese.locale
                ? 'https://github.com/ilgnefz/once_power#快速上手'
                : 'https://github.com/ilgnefz/once_power/blob/master/README-EN.md';
            await launchUrl(Uri.parse(url));
          },
        ),
        EasyClickText(
          label: 'GPL 3.0',
          onPressed: () async => await launchUrl(
            Uri.parse(
              'https://github.com/ilgnefz/once_power?tab=GPL-3.0-1-ov-file',
            ),
          ),
        ),
      ],
    );
  }
}
