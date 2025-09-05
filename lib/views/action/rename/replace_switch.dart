import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/match.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/easy_chip.dart';

class ReplaceSwitch extends ConsumerWidget {
  const ReplaceSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ReplaceType.values.map((e) {
        return EasyChip(
          label: e.label,
          selected: ref.watch(selectedReplaceTypeProvider).contains(e),
          enable: !ref.watch(isDateRenameProvider),
          fontSize: context.locale == Locale('en', "US") ? 13 : 14,
          onTap: () {
            ref.read(selectedReplaceTypeProvider.notifier).update(e);
            Debounce.run(() => updateName(ref));
          },
        );
      }).toList(),
    );
  }
}
