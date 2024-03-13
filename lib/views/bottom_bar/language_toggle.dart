import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/small_text_button.dart';

class LanguageToggle extends ConsumerStatefulWidget {
  const LanguageToggle({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends ConsumerState<LanguageToggle> {
  void toggleLanguage() {
    LanguageType languageType = ref.watch(currentLanguageProvider);
    if (languageType == LanguageType.chinese) {
      ref.read(languageProvider.notifier).update(const Locale('en', 'US'));
    } else {
      ref.read(languageProvider.notifier).update(const Locale('zh', 'CN'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final String language = S.of(context).language;
    LanguageType currentLanguage = ref.watch(currentLanguageProvider);
    return SmallTextButton(
      text: '$language: ${currentLanguage.value}',
      onTap: toggleLanguage,
    );
  }
}
