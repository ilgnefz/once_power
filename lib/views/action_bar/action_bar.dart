import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/views/action_bar/organize_menu/organize_menu.dart';
import 'package:once_power/widgets/mode_card.dart';

import 'rename_menu/rename_menu.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String replaceLabel = '替换';
    const String reserveLabel = '保留';
    const String organize = '整理';

    bool enableOrganize = ref.watch(useOrganizeProvider);

    return Column(
      children: [
        Container(
          width: AppNum.actionBarW,
          height: AppNum.topMenuH,
          color: Colors.white,
          child: Row(
            children: [
              const ModeCard(label: replaceLabel, mode: FunctionMode.replace),
              const ModeCard(label: reserveLabel, mode: FunctionMode.reserve),
              if (enableOrganize)
                const ModeCard(label: organize, mode: FunctionMode.organize),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppNum.actionBarP),
            width: AppNum.actionBarW,
            child: ref.watch(currentModeProvider) == FunctionMode.organize
                ? const OrganizeMenu()
                : const RenameMenu(),
          ),
        ),
      ],
    );
  }
}
