import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';

import 'advance/advance.dart';
import 'csv/csv.dart';
import 'date/date.dart';
import 'normal/normal.dart';
import 'organize/organize.dart';

class ActionView extends ConsumerWidget {
  const ActionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final List<FunctionMode> modes = FunctionMode.values;
    return SizedBox(
      width: AppNum.actionWidth,
      child: Builder(
        builder: (context) {
          if (ref.watch(cSVDataProvider).isNotEmpty) return CSVView();
          if (ref.watch(isDateModifyProvider)) return DateView();

          return DefaultTabController(
            initialIndex: modes.indexOf(ref.read(currentModeProvider)),
            length: modes.length,
            child: Column(
              children: [
                SizedBox(
                  height: AppNum.topHeight,
                  child: TabBar(
                    dividerHeight: 0,
                    indicatorColor: theme.primaryColor,
                    labelPadding: EdgeInsets.zero,
                    // labelColor: theme.primaryColor,
                    labelStyle: theme.tabBarTheme.labelStyle,
                    unselectedLabelStyle:
                        theme.tabBarTheme.unselectedLabelStyle,
                    // unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    tabs: modes.map((e) => Tab(text: e.label)).toList(),
                    onTap: (index) {
                      ref
                          .read(currentModeProvider.notifier)
                          .update(modes[index]);
                      if (index != 3 && ref.read(isViewModeProvider)) {
                        filterFile(ref);
                      }
                      Debounce.run(() => updateName(ref));
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: const [
                      NormalView(true),
                      NormalView(false),
                      AdvanceView(),
                      OrganizeView(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
