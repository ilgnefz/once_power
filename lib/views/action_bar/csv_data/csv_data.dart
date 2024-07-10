import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/views/action_bar/csv_data/csv_data_tile.dart';

final List<String> titles = ['A', 'B'];

class CsvDataView extends ConsumerWidget {
  const CsvDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<List<String>> list = ref.watch(cSVDataProvider);

    void toggleOriginNameColumn(int index) {
      ref.read(originNameColumnProvider.notifier).update(index);
      newFeatureRename(ref);
    }

    return Column(
      children: [
        CsvDataTile(
          height: 40,
          color: Theme.of(context).primaryColor.withOpacity(.4),
          list: titles,
          textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
              .useSystemChineseFont(),
          onTap: (index) => toggleOriginNameColumn(index),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => CsvDataTile(
              minHeight: 36,
              color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
              list: list[index],
            ),
          ),
        ),
      ],
    );
  }
}
