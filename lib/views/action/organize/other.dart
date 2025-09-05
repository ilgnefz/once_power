import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class OtherGroup extends ConsumerWidget {
  const OtherGroup({super.key});

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
            checked: ref.watch(useTopFolderProvider),
            label: tr(AppL10n.organizeTop),
            onChanged: ref.read(useTopFolderProvider.notifier).toggle,
          ),
          EasyCheckbox(
            checked: ref.watch(useDateClassifyProvider),
            label: tr(AppL10n.organizeDate),
            onChanged: ref.read(useDateClassifyProvider.notifier).toggle,
          ),
        ],
      ),
    );
  }
}
