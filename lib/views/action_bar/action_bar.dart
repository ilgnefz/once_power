import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/views/action_bar/csv_data/csv_data.dart';
import 'package:once_power/widgets/function_mode_card.dart';

import 'csv_data/csv_data_title.dart';
import 'organize_menu/organize_menu.dart';
import 'rename_menu/rename_menu.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String replace = S.of(context).replace;
    String reserve = S.of(context).reserve;
    String organize = S.of(context).organize;

    bool enableOrganize = ref.watch(enableOrganizeProvider);
    bool isMax = ref.watch(maxWindowProvider);
    double width = isMax ? AppNum.actionBarMaxW : AppNum.actionBarW;
    double padding = isMax ? AppNum.actionBarMaxP : AppNum.actionBarP;
    bool hasCSVData = ref.watch(cSVDataProvider).isNotEmpty;
    int originNameColumn = ref.watch(originNameColumnProvider);

    return Column(
      children: [
        hasCSVData
            ? Container(
                width: width,
                height: AppNum.topMenuH,
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: CsvDataTitle(originNameColumn == 0 ? 'A' : 'B'),
              )
            : Container(
                width: width,
                height: AppNum.topMenuH,
                color: Colors.white,
                child: Row(
                  children: [
                    FunctionModeTab(label: replace, mode: FunctionMode.replace),
                    FunctionModeTab(label: reserve, mode: FunctionMode.reserve),
                    if (enableOrganize)
                      FunctionModeTab(
                          label: organize, mode: FunctionMode.organize),
                  ],
                ),
              ),
        Expanded(
          child: Container(
            padding: hasCSVData
                ? EdgeInsets.only(
                    left: padding,
                    right: padding,
                    bottom: padding,
                  )
                : EdgeInsets.all(padding),
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
