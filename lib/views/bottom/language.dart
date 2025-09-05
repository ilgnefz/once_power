import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/widgets/common/text_btn.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  void _toggleLanguage(BuildContext context, bool isChinese) {
    context.setLocale(isChinese ? Locale('en', 'US') : Locale('zh', 'CN'));
  }

  @override
  Widget build(BuildContext context) {
    final bool isChinese = context.locale == LanguageType.chinese.locale;
    final String languageLabel = isChinese
        ? LanguageType.chinese.label
        : LanguageType.english.label;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextBtn(
        languageLabel,
        onPressed: () => _toggleLanguage(context, isChinese),
      ),
    );
  }
}
