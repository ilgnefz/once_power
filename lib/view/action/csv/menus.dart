import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/csv.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/common/checkbox.dart';

class MenuGroup extends ConsumerWidget {
  const MenuGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: ref.watch(deleteExtensionProvider),
            label: tr(AppL10n.csvDelete),
            onChanged: (v) {
              ref.read(deleteExtensionProvider.notifier).update();
              Debounce.run(() => cSVUpdateName(ref));
            },
          ),
          EasyCheckbox(
            checked: ref.watch(matchExtensionProvider),
            label: tr(AppL10n.csvMatch),
            onChanged: (v) {
              ref.read(matchExtensionProvider.notifier).update();
              Debounce.run(() => cSVUpdateName(ref));
            },
          ),
        ],
      ),
    );
  }
}
