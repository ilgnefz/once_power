import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/views/action_bar/action_tab_bar.dart';
import 'package:once_power/views/action_bar/organize/organize.dart';
import 'package:once_power/views/action_bar/rename/rename.dart';

import 'advance/advance.dart';
import 'csv_data/csv_data.dart';
import 'csv_data/csv_data_title.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double defaultP = AppNum.defaultP;
    EdgeInsets padding = const EdgeInsets.all(AppNum.defaultP);
    Widget tabBar = const ActionTabBar();
    Widget renameAction = const RenameAction();

    if (ref.watch(cSVDataProvider).isNotEmpty) {
      padding =
          EdgeInsets.only(left: defaultP, right: defaultP, bottom: defaultP);
      tabBar = const CsvDataTitle();
      renameAction = const CsvDataView();
    }

    return Column(
      children: [
        tabBar,
        Expanded(
          child: Container(
            width: AppNum.actionBarW,
            padding: ref.watch(currentModeProvider).isAdvance
                ? EdgeInsets.zero
                : padding,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                FunctionMode mode = ref.watch(currentModeProvider);
                if (mode.isOrganize) return const OrganizeAction();
                if (mode.isAdvance) return const AdvanceAction();
                return renameAction;
              },
            ),
          ),
        ),
      ],
    );
  }
}
