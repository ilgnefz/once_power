import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/views/action_bar/advance/advance.dart';
import 'package:once_power/views/action_bar/csv_data/csv_data.dart';
import 'package:once_power/views/action_bar/organize/organize.dart';
import 'package:once_power/views/action_bar/repalce/replace.dart';
import 'package:once_power/views/action_bar/reserve/reserve.dart';

import '../../cores/update_name.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool openExtraFunction = ref.watch(openExtraFunctionProvider);
    List<FunctionMode> modes = FunctionMode.values;
    if (!openExtraFunction) {
      modes =
          FunctionMode.values.where((e) => e != FunctionMode.advance).toList();
    }
    int index = modes.indexOf(ref.read(currentModeProvider));

    Widget child = DefaultTabController(
      length: modes.length,
      initialIndex: index < 0 ? 0 : index,
      child: Column(
        children: [
          SizedBox(
            height: AppNum.modeCardH,
            child: TabBar(
              dividerHeight: 0,
              // indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
              // indicatorSize: TabBarIndicatorSize.tab,
              // indicator: BoxDecoration(
              //   color: Colors.green.withValues(alpha: .5),
              //   borderRadius: BorderRadius.circular(8),
              // ),
              // indicatorWeight: 4,
              onTap: (index) {
                if (ref.watch(currentModeProvider).isReplace && index == 1) {
                  if (ref.watch(matchClearProvider) &&
                      ref.watch(modifyClearProvider)) {
                    ref.read(modifyControllerProvider.notifier).clear();
                  }
                }
                ref.read(currentModeProvider.notifier).update(modes[index]);
                updateName(ref);
              },
              labelPadding: EdgeInsets.zero,
              labelColor: AppColors.primary,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: AppColors.unselectText,
              unselectedLabelStyle: const TextStyle(),
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabs: modes.map((e) => Tab(text: e.label)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ReplaceMenu(),
                ReserveMenu(),
                if (openExtraFunction) AdvanceMenu(),
                OrganizeMenu(),
              ],
            ),
          ),
        ],
      ),
    );

    if (ref.watch(cSVDataProvider).isNotEmpty) child = CsvDataView();

    return SizedBox(
      width: AppNum.actionBarW,
      // color: Colors.grey.withValues(alpha: .3),
      child: child,
    );
  }
}
