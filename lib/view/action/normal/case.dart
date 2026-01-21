import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/common/checkbox.dart';

class CaseGroup extends ConsumerWidget {
  const CaseGroup({super.key});

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
            checked: ref.watch(caseFileProvider),
            label: tr(AppL10n.renameCaseFile),
            onChanged: (v) {
              ref.read(caseFileProvider.notifier).update();
              Debounce.run(() => normalUpdateName(ref));
            },
          ),
          EasyCheckbox(
            checked: ref.watch(caseExtProvider),
            label: tr(AppL10n.renameCaseExt),
            onChanged: (v) {
              ref.read(caseExtProvider.notifier).update();
              Debounce.run(() => normalUpdateName(ref));
            },
          ),
        ],
      ),
    );
  }
}
