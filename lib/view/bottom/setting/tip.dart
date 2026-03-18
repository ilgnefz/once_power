import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/text.dart';

class TipPanel extends StatelessWidget {
  const TipPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = tr(AppL10n.bottomHotKey);
    final String all = tr(AppL10n.bottomHotKeyAll);
    final String cancel = tr(AppL10n.bottomHotKeyCancel);
    final String delete = tr(AppL10n.bottomHotKeyDelete);
    final String toggle = tr(AppL10n.bottomHotKeyToggle);
    final String suspense = tr(AppL10n.bottomHotKeySuspense);
    final String front = tr(AppL10n.bottomHotKeyFront);
    final String behind = tr(AppL10n.bottomHotKeyBehind);

    return Padding(
      padding: .only(right: AppNum.spaceMedium),
      child: Row(
        spacing: AppNum.spaceMedium,
        crossAxisAlignment: .start,
        children: [
          BaseText('$title:'),
          Expanded(
            child: Wrap(
              runSpacing: AppNum.spaceMedium,
              alignment: .spaceBetween,
              children: [
                BaseText('Ctrl+A  $all'),
                BaseText('Ctrl+D  $cancel'),
                BaseText('Delete  $delete'),
                BaseText('Ctrl+S  $toggle'),
                BaseText('Ctrl+X  $suspense'),
                BaseText('Ctrl+C  $front'),
                BaseText('Ctrl+V  $behind'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
