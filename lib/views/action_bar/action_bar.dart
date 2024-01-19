import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/mode_card.dart';

import 'arrange_menu/arrange_menu.dart';
import 'rename_menu/rename_menu.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String replace = '替换';
    const String reserve = '保留';
    const String organize = '整理';
    bool enableArrange = ref.watch(enableArrangeProvider);
    bool max = ref.watch(maxWindowProvider);
    double width = max ? AppNum.actionBarW + 8 : AppNum.actionBarW;

    return Column(
      children: [
        Container(
          width: width,
          height: AppNum.topMenuH,
          color: Colors.white,
          child: Row(
            children: [
              const ModeCard(label: replace, mode: FunctionMode.replace),
              const ModeCard(label: reserve, mode: FunctionMode.reserve),
              if (enableArrange)
                const ModeCard(label: organize, mode: FunctionMode.organize),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(max ? 16 : AppNum.actionBarP),
            width: width,
            child: ref.watch(currentModeProvider) == FunctionMode.organize
                ? const ArrangeMenu()
                : const RenameMenu(),
          ),
        ),
      ],
    );
  }
}
