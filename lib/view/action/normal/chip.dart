import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/enum/match.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/chip.dart';

class MatchChip extends ConsumerWidget {
  const MatchChip(this.isReplace, {super.key});

  final bool isReplace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> chips = isReplace
        ? ReplaceType.values.map((e) {
            return EasyChip(
              label: e.label,
              selected: ref.watch(selectedReplaceTypeProvider).contains(e),
              // fontSize: context.locale == Locale('en', "US") ? 13 : 14,
              fontSize: 14,
              onTap: () {
                ref.read(selectedReplaceTypeProvider.notifier).update(e);
                Debounce.run(() => normalUpdateName(ref));
              },
            );
          }).toList()
        : ReserveType.values.map((e) {
            return EasyChip(
              label: e.label,
              selected: ref.watch(selectedReserveTypeProvider).contains(e),
              // fontSize: context.locale == Locale('en', "US") ? 13 : 14,
              fontSize: 14,
              onTap: () {
                ref.read(selectedReserveTypeProvider.notifier).update(e);
                Debounce.run(() => normalUpdateName(ref));
              },
            );
          }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: chips,
      ),
    );
  }
}
