import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_split_pane/flutter_split_pane.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/view/content/top/sort.dart';
import 'package:once_power/widget/base/text.dart';

class NormalTop extends ConsumerWidget {
  const NormalTop({super.key, required this.isOrganize});

  final bool isOrganize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = context.tr(isOrganize ? AppL10n.name : AppL10n.originName);
    String subtitle = context.tr(isOrganize ? AppL10n.folder : AppL10n.newName);
    final (int count, int total) = ref.watch(
      fileListProvider.select(
        (List<FileInfo> files) =>
            (files.where((FileInfo e) => e.checked).length, files.length),
      ),
    );
    if (ref.watch(isSwapLabelProvider)) (title, subtitle) = (subtitle, title);
    return SplitPane(
      views: [
        SplitPaneView(
          minExtent: 100.0,
          child: Row(children: [OneLineText('$title ($count/$total)')]),
        ),
        SplitPaneView(
          minExtent: 100.0,
          child: Row(children: [OneLineText(subtitle), const TopSort()]),
        ),
      ],
      style: SplitPaneStyle(
        idleColor: Theme.of(context).dividerColor,
        dividerThickness: 1.0,
        dividerExtent: 20.0,
        dividerSpaceEnd: AppNumber.spaceMedium,
      ),
      onRatiosCommitted: (ratios) =>
          ref.read(splitValuesProvider.notifier).update(ratios),
    );
  }
}
