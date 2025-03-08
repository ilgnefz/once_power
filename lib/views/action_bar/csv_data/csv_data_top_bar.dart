import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/value.dart';

import '../../../cores/update_name.dart';

class CsvDataTopBar extends ConsumerWidget {
  const CsvDataTopBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: AppNum.actionBarW,
      height: AppNum.modeCardH,
      padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      child: Row(
        spacing: AppNum.mediumG,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: S.of(context).tableInfo,
              style:
                  const TextStyle(color: Colors.black).useSystemChineseFont(),
              children: [
                TextSpan(
                  text: ref.watch(cSVNameColumnProvider),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              ref.read(cSVDataProvider.notifier).update([]);
              updateName(ref);
            },
            child: Text(S.of(context).exit),
          ),
        ],
      ),
    );
  }
}
