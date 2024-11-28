import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';

class CsvDataTitle extends ConsumerWidget {
  const CsvDataTitle({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tableInfo = S.of(context).tableInfo;
    final String label = S.of(context).exit;

    String originNameColumn = ref.watch(cSVNameColumnProvider);

    void exit() {
      ref.read(cSVDataProvider.notifier).update([]);
      updateName(ref);
    }

    return Container(
      width: AppNum.actionBarW,
      height: AppNum.modeCardH,
      padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: tableInfo,
              style:
                  const TextStyle(color: Colors.black).useSystemChineseFont(),
              children: [
                TextSpan(
                  text: originNameColumn,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(onPressed: exit, child: Text(label)),
        ],
      ),
    );
  }
}
