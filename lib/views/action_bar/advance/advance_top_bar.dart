import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/widgets/action_bar/sub_top_bar.dart';

class AdvanceTopBar extends ConsumerWidget {
  const AdvanceTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);
    String presetName = ref.watch(currentPresetNameProvider);
    String title = S.current.totalDirectives(list.length);
    return SubTopBar(
      title: presetName.isNotEmpty ? '$title - $presetName' : title,
      onDelete: () {
        ref.read(advanceMenuListProvider.notifier).setList([]);
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    );
  }
}
