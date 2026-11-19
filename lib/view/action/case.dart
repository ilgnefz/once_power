import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/base/checkbox.dart';

class CaseGroup extends ConsumerWidget {
  const CaseGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNumber.paddingSmall,
        right: AppNumber.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: ref.watch(isCaseTypeProvider),
            label: context.tr(AppL10n.caseFile),
            onChanged: (v) => ref.read(isCaseTypeProvider.notifier).toggle(),
          ),
          EasyCheckbox(
            checked: ref.watch(isCaseExtensionProvider),
            label: context.tr(AppL10n.caseExtension),
            onChanged: (v) =>
                ref.read(isCaseExtensionProvider.notifier).toggle(),
          ),
        ],
      ),
    );
  }
}
