import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/action_bar/easy_chip.dart';

class SelectReplaceType extends ConsumerWidget {
  const SelectReplaceType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ReplaceType.values.map(
        (e) {
          return EasyChip(
            label: e.label,
            selected: ref.watch(currentReplaceTypeProvider).contains(e),
            // enable: false,
            fontSize: ref.watch(currentLanguageProvider).isEnglish() ? 13 : 14,
            onTap: () {
              ref.read(currentReplaceTypeProvider.notifier).update(e);
              updateName(ref);
            },
          );
        },
      ).toList(),
    );
  }
}
