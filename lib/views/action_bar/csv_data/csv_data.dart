import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/views/action_bar/csv_data/csv_data_tile.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/additional_options.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/apply_menu.dart';
import 'package:once_power/widgets/action_bar/view_structure.dart';

class CsvDataView extends ConsumerWidget {
  const CsvDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> titles = ['A', 'B'];

    final TextStyle tileTextStyle = const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
        .useSystemChineseFont();

    List<List<String>> list = ref.watch(cSVDataProvider);

    void toggleCSVNameColumn(int index) {
      ref.read(cSVNameColumnProvider.notifier).update(index);
      cSVDataRename(ref);
    }

    return ViewStructure(
      topAction: Column(
        children: [
          CsvDataTile(
            height: AppNum.cSVDataTileH,
            color: Theme.of(context).primaryColor.withOpacity(.4),
            list: titles,
            textStyle: tileTextStyle,
            onTap: (index) => toggleCSVNameColumn(index),
          ),
          Expanded(
            child: SelectionArea(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => CsvDataTile(
                  minHeight: AppNum.cSVDataMinH,
                  color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
                  list: list[index],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomActions: const [
        AdditionalOptions(),
        SizedBox(height: AppNum.mediumG),
        ApplyMenu()
      ],
    );
  }
}
