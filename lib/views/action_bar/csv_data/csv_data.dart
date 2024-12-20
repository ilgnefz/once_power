import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/file_info.dart';
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

    List<EasyRenameInfo> list = ref.watch(cSVDataProvider);

    void toggleCSVNameColumn(String value) {
      ref.read(cSVNameColumnProvider.notifier).update(value);
      cSVDataRename(ref);
    }

    return ViewStructure(
      topAction: Column(
        children: [
          Row(
            children: titles
                .map((e) => Expanded(
                      child: InkWell(
                        onTap: () => toggleCSVNameColumn(e),
                        child: Container(
                          height: AppNum.cSVDataTileH,
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: .4),
                          alignment: Alignment.center,
                          child: Text(e, style: tileTextStyle),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => ColoredBox(
                color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
                child: Row(
                  children: [
                    CsvDataTile(
                      index: index,
                      flag: 'A',
                      text: list[index].nameA,
                    ),
                    CsvDataTile(
                      index: index,
                      flag: 'B',
                      text: list[index].nameB,
                    ),
                    // CsvDataTile(text: list[index].nameA, index: null,),
                    // CsvDataTile(text: list[index].nameB, index: null,),
                    // Expanded(
                    //   child: InkWell(
                    //     child: Container(
                    //       constraints: BoxConstraints(
                    //         minHeight: AppNum.cSVDataMinH,
                    //       ),
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 8,
                    //         vertical: 4,
                    //       ),
                    //       width: double.infinity,
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         list[index].nameB,
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(fontSize: 13)
                    //             .useSystemChineseFont(),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomActions: const [
        AdditionalOptions(show: false),
        SizedBox(height: AppNum.mediumG),
        ApplyMenu()
      ],
    );
  }
}
