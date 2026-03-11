import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/widget/bottom/text.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

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
      child: BottomTextButton(
        languageLabel,
        onPressed: () => _toggleLanguage(context, isChinese),
      ),
    );
  }
}
