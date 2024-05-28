import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/small_text_button.dart';

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LanguageType currentLanguage = ref.watch(currentLanguageProvider);
    bool showTextTip = ref.watch(showTextTipProvider);

    String text = currentLanguage.value;
    String tip = '(${S.of(context).restartTip})';

    void toggleLanguage() {
      LanguageType languageType = ref.watch(currentLanguageProvider);
      if (languageType == LanguageType.chinese) {
        ref.read(languageProvider.notifier).update(const Locale('en', 'US'));
      } else {
        ref.read(languageProvider.notifier).update(const Locale('zh', 'CN'));
      }
      ref.read(showTextTipProvider.notifier).update();
    }

    return SmallTextButton(
      text: showTextTip ? "$text$tip" : text,
      onTap: toggleLanguage,
    );
  }
}
