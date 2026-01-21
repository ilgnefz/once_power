import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/view/content/top/filter.dart';
import 'package:once_power/view/content/top/sort.dart';
import 'package:once_power/widget/context/item.dart';

final _labelLeftProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(fileListProvider);
  int total = files.length;
  int checked = files.where((e) => e.checked).toList().length;
  String name = ref.watch(currentModeProvider).isOrganize
      ? tr(AppL10n.contentName)
      : tr(AppL10n.contentOrigin);
  return '$name ($checked/$total)';
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
    return ContentItem(
      checked: ref.watch(selectAllProvider),
      onChanged: (bool? value) => ref.read(selectAllProvider.notifier).update(),
      margin: EdgeInsets.only(right: AppNum.padding),
      title: ref.watch(_labelLeftProvider),
      subTitle: ref.watch(_labelRightProvider),
      subTitleAction: SortButton(),
      action: FilterButton(),
      icon: Icons.delete_rounded,
      onDelete: ref.read(fileListProvider.notifier).clear,
    );
  }
}
