import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/bottom_bar/text_btn.dart';

class LanguageToggleBtn extends ConsumerWidget {
  const LanguageToggleBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String label = ref.watch(currentLanguageProvider).label;
    String tip = '(${S.of(context).restartTip})';

    void toggleLanguage() {
      LanguageType languageType = ref.watch(currentLanguageProvider);
      if (languageType == LanguageType.chinese) {
        ref.read(languageProvider.notifier).update(const Locale('en', 'US'));
      } else {
        ref.read(languageProvider.notifier).update(const Locale('zh', 'CN'));
      }
      ref.read(isShowTipProvider.notifier).update();
    }

    return TextBtn(
      margin: EdgeInsets.symmetric(horizontal: AppNum.smallG),
      text: ref.watch(isShowTipProvider) ? "$label$tip" : label,
      onTap: toggleLanguage,
    );
  }
}
