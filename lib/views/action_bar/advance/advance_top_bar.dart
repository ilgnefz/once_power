import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/widgets/action_bar/sub_top_bar.dart';

class AdvanceTopBar extends ConsumerWidget {
  const AdvanceTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);
    return SubTopBar(
      title: S.current.totalDirectives(list.length),
      onOperate: () async {},
      onDelete: () {
        ref.read(advanceMenuListProvider.notifier).setList([]);
        advanceUpdateName(ref);
      },
    );
  }
}
