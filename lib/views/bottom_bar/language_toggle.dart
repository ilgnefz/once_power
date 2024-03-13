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
  bool show = false;

  void toggleLanguage() {
    LanguageType languageType = ref.watch(currentLanguageProvider);
    if (languageType == LanguageType.chinese) {
      ref.read(languageProvider.notifier).update(const Locale('en', 'US'));
    } else {
      ref.read(languageProvider.notifier).update(const Locale('zh', 'CN'));
    }
    show = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String language = S.of(context).language;
    LanguageType currentLanguage = ref.watch(currentLanguageProvider);
    String text = '$language: ${currentLanguage.value}';
    String tip = '(${S.of(context).restartTip})';
    return SmallTextButton(
      text: show ? "$text$tip" : text,
      onTap: toggleLanguage,
    );
  }
}
