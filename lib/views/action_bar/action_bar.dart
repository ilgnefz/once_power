import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/mode_card.dart';

import 'organize_menu/organize_menu.dart';
import 'rename_menu/rename_menu.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String replace = S.of(context).replace;
    String reserve = S.of(context).reserve;
    String organize = S.of(context).organize;
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
              ModeCard(label: replace, mode: FunctionMode.replace),
              ModeCard(label: reserve, mode: FunctionMode.reserve),
              if (enableArrange)
                ModeCard(label: organize, mode: FunctionMode.organize),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(max ? 16 : AppNum.actionBarP),
            width: width,
            child: ref.watch(currentModeProvider) == FunctionMode.organize
                ? const OrganizeMenu()
                : const RenameMenu(),
          ),
        ),
      ],
    );
  }
}
