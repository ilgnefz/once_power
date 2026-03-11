import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/widget/bottom/icon.dart';

class DateButton extends ConsumerWidget {
  const DateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: tr(AppL10n.bottomDate),
      icon: Icons.date_range,
      selected: ref.watch(isDateModifyProvider),
      onPressed: () {
        bool isCSV = ref.read(cSVDataProvider).isNotEmpty;
        if (isCSV) return showDateWarningNotification();
        ref.read(isDateModifyProvider.notifier).toggle();
      },
    );
  }
}
