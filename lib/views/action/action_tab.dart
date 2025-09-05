import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/select.dart';

import 'advance/advance.dart';
import 'organize/organize.dart';
import 'rename/rename.dart';
import 'rename/replace_switch.dart';
import 'rename/reserve_switch.dart';

class ActionTabBar extends ConsumerWidget {
  const ActionTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final List<FunctionMode> modes = FunctionMode.values;
    int index = modes.indexOf(ref.read(currentModeProvider));
    return DefaultTabController(
      initialIndex: index,
      length: modes.length,
      child: Column(
        children: [
          SizedBox(
            height: AppNum.actionTop,
            child: TabBar(
              dividerHeight: 0,
              indicatorColor: theme.primaryColor,
              labelPadding: EdgeInsets.zero,
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabs: modes.map((e) => Tab(text: e.label)).toList(),
              onTap: (index) {
                // if (ref.watch(currentModeProvider).isReplace && index == 1) {
                //   if (ref.watch(matchClearProvider) &&
                //       ref.watch(modifyClearProvider)) {
                //     ref.read(modifyControllerProvider.notifier).clear();
                //   }
                // }
                ref.read(currentModeProvider.notifier).update(modes[index]);
                // if (ref.watch(isViewModeProvider) && index < 3) {
                //   filterFile(context, ref);
                // }
                updateName(ref);
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              children: const [
                RenameMenu(slot: ReplaceSwitch()),
                RenameMenu(slot: ReserveSwitch()),
                AdvanceView(),
                OrganizeView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
