import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/table.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/csv.dart';
import 'package:once_power/model/csv.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/view/action/add.dart';
import 'package:once_power/view/action/apply.dart';
import 'package:once_power/view/action/csv/menus.dart';
import 'package:once_power/view/action/csv/top.dart';
import 'package:once_power/view/action/picker.dart';

import 'item.dart';

class CSVView extends ConsumerWidget {
  const CSVView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TableTheme? theme = Theme.of(context).extension<TableTheme>();
    final List<String> titles = ['A', 'B'];
    List<CSVRenameInfo> list = ref.watch(cSVDataProvider);

    return Column(
      children: [
        const CSVTop(),
        Padding(
          padding: .symmetric(horizontal: AppNum.padding),
          child: Row(
            children: titles.map((e) {
              return Expanded(
                child: InkWell(
                  mouseCursor: SystemMouseCursors.click,
                  onTap: () {
                    ref.read(cSVNameColumnProvider.notifier).update(e);
                    cSVUpdateName(ref);
                  },
                  child: Container(
                    height: AppNum.csvDataHeight,
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  CsvDataItem(index: index, flag: 'A', text: list[index].nameA),
                  CsvDataItem(index: index, flag: 'B', text: list[index].nameB),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppNum.spaceSmall),
        MenuGroup(),
        AddGroup(),
        SizedBox(height: AppNum.spaceMedium),
        FilePickerGroup(slot: ApplyButton()),
        SizedBox(height: AppNum.spaceMedium),
      ],
    );
  }
}
