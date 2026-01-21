import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/action/elevated_button.dart';

class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedButton(
      label: tr(AppL10n.renameApply),
      onPressed: () {
        String match = ref.watch(matchControllerProvider).text;
        print('匹配内容: $match');
        String replace = ref.watch(modifyControllerProvider).text;
        print('替换内容: $replace');
        int dateDigit = ref.watch(dateDigitProvider);
        String dateType = ref.watch(currentDateTypeProvider).label;
        print('日期类型: $dateType -- $dateDigit');
        String prefix = ref.watch(prefixControllerProvider).text;
        bool prefixCycle = ref.watch(isCyclePrefixProvider);
        int prefixDigit = ref.watch(prefixDigitProvider);
        int prefixStart = ref.watch(prefixStartProvider);
        print('前缀内容: $prefix -- $prefixCycle -- $prefixDigit -- $prefixStart');
        String suffix = ref.watch(suffixControllerProvider).text;
        bool suffixCycle = ref.watch(isCycleSuffixProvider);
        int suffixDigit = ref.watch(suffixDigitProvider);
        int suffixStart = ref.watch(suffixStartProvider);
        print('后缀内容: $suffix -- $suffixCycle -- $suffixDigit -- $suffixStart');
      },
    );
  }
}
