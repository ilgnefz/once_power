import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/text_btn.dart';

class LanguageToggleBtn extends ConsumerWidget {
  const LanguageToggleBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LanguageType currentLanguage = ref.watch(currentLanguageProvider);
    bool showTip = ref.watch(showTipProvider);

    String label = currentLanguage.value;
    String tip = '(${S.of(context).restartTip})';

    void toggleLanguage() {
      LanguageType languageType = ref.watch(currentLanguageProvider);
      if (languageType == LanguageType.chinese) {
        ref.read(languageProvider.notifier).update(const Locale('en', 'US'));
      } else {
        ref.read(languageProvider.notifier).update(const Locale('zh', 'CN'));
      }
      ref.read(showTipProvider.notifier).update();
    }

    return TextBtn(
      text: showTip ? "$label$tip" : label,
      onTap: toggleLanguage,
    );
  }
}
