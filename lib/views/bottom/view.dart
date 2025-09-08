import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class ViewBtn extends ConsumerWidget {
  const ViewBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: tr(AppL10n.bottomView),
      svg: AppIcons.image,
      selected: ref.watch(isViewModeProvider),
      onPressed: () {
        ref.read(isViewModeProvider.notifier).update();
        if (ref.read(isViewModeProvider)) {
          filterFile(ref);
          updateName(ref);
        }
      },
    );
  }
}
