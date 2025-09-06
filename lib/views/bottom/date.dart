import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class DateModifyBtn extends ConsumerWidget {
  const DateModifyBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: tr(AppL10n.bottomDate),
      icon: Icons.date_range,
      selected: ref.watch(isDateModifyProvider),
      onPressed: () {
        ref.read(isDateModifyProvider.notifier).toggle();
        if (!ref.watch(isDateModifyProvider)) updateName(ref);
      },
    );
  }
}
