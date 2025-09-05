import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/select.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/content/top/adjust_size.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/base/one_line_text.dart';
import 'package:once_power/widgets/common/click_icon.dart';

import 'filter.dart';
import 'sort.dart';
import 'visible.dart';

final _labelProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(fileListProvider);
  int total = files.length;
  int checked = files.where((e) => e.checked).toList().length;
  return '${tr(AppL10n.contentOrigin)} ($checked/$total)';
});

class ViewTop extends ConsumerWidget {
  const ViewTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(right: 12),
      child: Row(
        children: [
          SizedBox(width: 4),
          EasyCheckbox(
            label: '',
            checked: ref.watch(selectAllProvider),
            onChanged: () => selectAll(ref),
          ),
          OneLineText(ref.watch(_labelProvider)),
          AdjustSize(),
          SizedBox(width: 4),
          ContentVisible(),
          SizedBox(width: 8),
          SortBtn(),
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
