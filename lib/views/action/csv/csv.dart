import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/table.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/csv.dart';
import 'package:once_power/models/csv.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/views/action/add_group.dart';
import 'package:once_power/views/action/apply.dart';
import 'package:once_power/views/action/apply_group.dart';
import 'package:once_power/views/action/csv/ext_group.dart';
import 'package:once_power/views/action/csv/top.dart';

import 'date_card.dart';

class CSVView extends ConsumerWidget {
  const CSVView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<TableTheme>();
    final List<String> titles = ['A', 'B'];

    TextStyle textStyle = const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    List<CsvRenameInfo> list = ref.watch(cSVDataProvider);

    void toggleCSVNameColumn(String value) {
      ref.read(cSVNameColumnProvider.notifier).update(value);
      csvDataRename(ref);
    }

    return Column(
      children: [
        CsvDataTop(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
          child: Row(
            children: titles.map((e) {
              return Expanded(
                child: InkWell(
                  onTap: () => toggleCSVNameColumn(e),
                  child: Container(
                    height: AppNum.csvData,
                    color: Theme.of(context).primaryColor,
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
              margin: EdgeInsets.symmetric(horizontal: AppNum.padding),
              color: index % 2 == 0
                  ? theme?.backgroundColor1
                  : theme?.backgroundColor2,
              child: Row(
                children: [
                  CsvDataCard(index: index, flag: 'A', text: list[index].nameA),
                  CsvDataCard(index: index, flag: 'B', text: list[index].nameB),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppNum.spaceSmall),
        ExtGroup(),
        AddGroup(),
        SizedBox(height: AppNum.spaceMedium),
        ApplyGroup(slot: ApplyRename()),
        SizedBox(height: AppNum.spaceMedium),
      ],
    );
  }
}
