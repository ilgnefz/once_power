import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/enums/match.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/easy_chip.dart';

final _enableProvider = Provider((ref) {
  if (ref.watch(currentModeProvider).isReserve) {
    return !ref.watch(matchClearProvider) &&
        !ref.watch(modifyClearProvider) &&
        !ref.watch(isDateRenameProvider);
  }
  return true;
});

class ReserveSwitch extends ConsumerWidget {
  const ReserveSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...ReserveType.values.map((e) {
          return EasyChip(
            label: e.label,
            selected: ref.watch(selectedReserveTypeProvider).contains(e),
            enable: ref.watch(_enableProvider),
            onTap: () {
              ref.read(selectedReserveTypeProvider.notifier).update(e);
              Debounce.run(() => updateName(ref));
            },
          );
        }),
      ],
    );
  }
}
