import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/select.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/views/content/top/export.dart';
import 'package:once_power/views/content/top/view_top.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/base/one_line_text.dart';
import 'package:once_power/widgets/common/click_icon.dart';

import 'expend.dart';
import 'filter.dart';
import 'sort.dart';
import 'visible.dart';

final _labelLeftProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(fileListProvider);
  int total = files.length;
  int checked = files.where((e) => e.checked).toList().length;
  return '${tr(AppL10n.contentOrigin)} ($checked/$total)';
});

final _labelRightProvider = Provider((ref) {
  return ref.watch(currentModeProvider).isOrganize
      ? tr(AppL10n.organizeFolder)
      : tr(AppL10n.contentNew);
});

class ContentTop extends ConsumerWidget {
  const ContentTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(currentModeProvider).isOrganize &&
        ref.watch(isViewModeProvider)) {
      return ViewTop();
    }

    return Container(
      height: 40,
      padding: EdgeInsets.only(right: 12),
      child: Row(
        children: [
          SizedBox(width: 4),
          EasyCheckbox(
            label: '',
            checked: ref.watch(selectAllProvider),
            onChanged: (v) => selectAll(ref),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                OneLineText(ref.watch(_labelLeftProvider)),
                ContentExpend(),
                SizedBox(width: 4),
                ExportBtn(),
                SizedBox(width: 4),
                if (!ref.watch(currentModeProvider).isOrganize)
                  ContentVisible(),
                SizedBox(width: 8),
              ],
            ),
          ),
          Flexible(
            flex: ref.watch(expandNewNameProvider) ? 2 : 1,
            child: Row(
              children: [
                OneLineText(ref.watch(_labelRightProvider)),
                SortBtn(),
              ],
            ),
          ),
          FilterBtn(),
          SizedBox(width: 4),
          ClickIcon(
            icon: Icons.delete,
            onPressed: ref.read(fileListProvider.notifier).clear,
          ),
        ],
      ),
    );
  }
}
