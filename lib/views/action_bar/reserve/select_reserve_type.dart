import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/easy_chip.dart';

import '../../../cores/update_name.dart';

class SelectReserveType extends ConsumerWidget {
  const SelectReserveType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...ReserveType.values.map(
          (e) {
            return EasyChip(
              label: e.label,
              selected: ref.watch(currentReserveTypeProvider).contains(e),
              enable: !ref.watch(matchClearProvider) &&
                  !ref.watch(modifyClearProvider) &&
                  !ref.watch(isDateRenameProvider),
              onTap: () {
                ref.read(currentReserveTypeProvider.notifier).update(e);
                updateName(ref);
              },
            );
          },
        ),
      ],
    );
  }
}
