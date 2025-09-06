import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class ExtGroup extends ConsumerWidget {
  const ExtGroup({super.key});

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
              Debounce.run(() => updateName(ref));
            },
          ),
          EasyCheckbox(
            checked: ref.watch(matchExtensionProvider),
            label: tr(AppL10n.csvMatch),
            onChanged: (v) {
              ref.read(matchExtensionProvider.notifier).update();
              Debounce.run(() => updateName(ref));
            },
          ),
        ],
      ),
    );
  }
}
