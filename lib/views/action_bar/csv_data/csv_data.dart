import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/custom_theme.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/csv_rename.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/views/action_bar/csv_data/delete_extension_checkbox.dart';
import 'package:once_power/views/action_bar/csv_data/match_extension_checkbox.dart';
import 'package:once_power/views/action_bar/rename/add_folder_checkbox.dart';
import 'package:once_power/views/action_bar/rename/append_checkbox.dart';
import 'package:once_power/views/action_bar/rename/apply_rename_btn.dart';
import 'package:once_power/widgets/action_bar/add_file_group.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';

import 'csv_data_card.dart';
import 'csv_data_top_bar.dart';

class CsvDataView extends ConsumerWidget {
  const CsvDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<TableTheme>();
    final List<String> titles = ['A', 'B'];

    TextStyle textStyle = const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
        .useSystemChineseFont();

    List<CsvRenameInfo> list = ref.watch(cSVDataProvider);

    void toggleCSVNameColumn(String value) {
      ref.read(cSVNameColumnProvider.notifier).update(value);
      cSVDataRename(ref);
    }

    return Column(
      children: [
        CsvDataTopBar(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
          child: Row(
            children: titles.map((e) {
              return Expanded(
                child: InkWell(
                  onTap: () => toggleCSVNameColumn(e),
                  child: Container(
                    height: AppNum.cSVDataH,
                    color: Theme.of(context).primaryColor.withValues(alpha: .4),
                    alignment: Alignment.center,
                    child: Text(e, style: textStyle),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => Container(
              key: UniqueKey(),
              margin: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
              color: index % 2 == 0 ? theme?.background1 : theme?.background2,
              child: Row(
                children: [
                  CsvDataCard(index: index, flag: 'A', text: list[index].nameA),
                  CsvDataCard(index: index, flag: 'B', text: list[index].nameB),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppNum.smallG),
        TwoCheckboxGroup(
          children: [DeleteExtensionCheckbox(), MatchExtensionCheckbox()],
        ),
        TwoCheckboxGroup(children: [AddFolderCheckbox(), AppendCheckbox()]),
        AddFolderGroup(child: ApplyRenameBtn()),
      ],
    );
  }
}
