import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/preset.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/checkbox.dart';

class ExportPresetView extends ConsumerStatefulWidget {
  const ExportPresetView({super.key});

  @override
  ConsumerState<ExportPresetView> createState() => _ExportPresetViewState();
}

class _ExportPresetViewState extends ConsumerState<ExportPresetView> {
  List<AdvancePreset> items = [];

  @override
  Widget build(BuildContext context) {
    List<AdvancePreset> list = ref.watch(advancePresetListProvider);
    return EasyDialog(
      title: tr(AppL10n.advanceExport),
      content: ReorderableListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        // itemExtent: ,
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          AdvancePreset item = list[oldIndex];
          ref.read(advancePresetListProvider.notifier).remove(item);
          ref.read(advancePresetListProvider.notifier).insert(newIndex, item);
        },
        proxyDecorator: (proxy, original, information) {
          return Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            borderRadius: .circular(AppNum.radiusSmall),
            child: proxy,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          AdvancePreset preset = list[index];
          return ReorderableDragStartListener(
            index: index,
            key: ValueKey(preset.id),
            child: InkWell(
              borderRadius: .circular(AppNum.radiusSmall),
              mouseCursor: SystemMouseCursors.click,
              onTap: () => setState(() {
                items.contains(preset)
                    ? items.remove(preset)
                    : items.add(preset);
              }),
              child: EasyCheckbox(
                label: preset.name,
                checked: items.contains(preset),
                onChanged: (value) => setState(
                  () => value! ? items.add(preset) : items.remove(preset),
                ),
              ),
            ),
          );
        },
      ),
      extraButton: EasyCheckbox(
        checked: items.length == list.length,
        label: tr(AppL10n.advanceSelectedAll),
        onChanged: (value) => setState(() {
          items.clear();
          if (value!) items.addAll(list);
        }),
      ),
      onOk: () => exportPreset(ref, items),
    );
  }
}
