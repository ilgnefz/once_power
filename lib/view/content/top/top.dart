import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:once_power/view/content/list/item.dart';
import 'package:once_power/view/content/top/adjust_size.dart';
import 'package:once_power/view/content/top/expand.dart';
import 'package:once_power/view/content/top/visible.dart';

import 'export.dart';
import 'filter.dart';
import 'sort.dart';

final Provider<String> _countProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(fileListProvider);
  int total = files.length;
  int checked = files.where((e) => e.checked).toList().length;
  return '($checked/$total)';
});

final Provider<String> _labelLeftProvider = Provider(
  (ref) => ref.watch(currentModeProvider).isOrganize
      ? tr(AppL10n.contentName)
      : tr(AppL10n.contentOrigin),
);

final Provider<String> _labelRightProvider = Provider((Ref ref) {
  if (ref.watch(isDateModifyProvider) || ref.watch(_onlyViewMode)) return '';
  return ref.watch(currentModeProvider).isOrganize
      ? tr(AppL10n.organizeFolder)
      : tr(AppL10n.contentNew);
});

final Provider<bool> _onlyViewMode = Provider((ref) {
  return (!ref.watch(currentModeProvider).isOrganize &&
          ref.watch(isViewModeProvider)) ||
      ref.watch(isDateModifyProvider);
});

class ContentTop extends ConsumerWidget {
  const ContentTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (title, subtitle) = ref.watch(swapLabelProvider)
        ? (ref.watch(_labelRightProvider), ref.watch(_labelLeftProvider))
        : (ref.watch(_labelLeftProvider), ref.watch(_labelRightProvider));
    return ContentItem(
      checked: ref.watch(selectAllProvider),
      onChanged: (bool? value) {
        ref.read(selectAllProvider.notifier).update();
        updateName(ref);
      },
      margin: EdgeInsets.only(right: AppNum.padding),
      title: '$title ${ref.watch(_countProvider)}',
      titleFontSize: 14,
      titleAction: [
        if (!ref.watch(_onlyViewMode)) ...[
          ContentExpend(),
          SizedBox(width: AppNum.spaceSmall),
          ExportFileButton(),
          SizedBox(width: AppNum.spaceSmall),
          ContentVisible(),
        ],
      ],
      subTitle: subtitle,
      subFontSize: 14,
      subTitleAction: [
        if (ref.watch(_onlyViewMode)) ...[
          ExportFileButton(),
          SizedBox(width: AppNum.spaceSmall),
          ContentVisible(),
          SizedBox(width: AppNum.spaceSmall),
          AdjustSize(),
        ],
        SortButton(),
      ],
      action: FilterButton(),
      icon: Icons.delete_rounded,
      onDelete: ref.read(fileListProvider.notifier).clear,
    );
  }
}
