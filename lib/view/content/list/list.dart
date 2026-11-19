import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_multi_select_reorder/flutter_multi_select_reorder.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/controller.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widget/content/selected.dart';

import 'item.dart';

class ContentListView extends ConsumerWidget {
  const ContentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> files = ref.watch(sortListProvider);
    return MultiSelectReorder.list(
      controller: ref.watch(selectionControllerProvider),
      padding: .only(right: AppNumber.padding),
      itemExtent: AppNumber.topHeight,
      itemCount: files.length,
      onSecondaryTap: (index, globalPosition) {},
      itemKeyBuilder: (index) => ValueKey<String>(files[index].id),
      itemId: (int index) => files[index].id,
      itemBuilder: (_, index, _) => ContentListItem(file: files[index]),
      onReorder: (oldIndices, newIndices) =>
          ref.read(fileListProvider.notifier).reorder(oldIndices, newIndices),
      style: MultiSelectStyle(
        mouseCursor: SystemMouseCursors.click,
        borderRadius: .circular(AppNumber.radius),
        selectedBuilder: (child, index, selectedIndex, selectedCount) =>
            SelectedItem(
              index: selectedCount > 1 ? selectedIndex : null,
              child: child,
            ),
        placeholderColor: Colors.transparent,
        placeholderBuilder: (_) => const SizedBox.shrink(),
      ),
    );
  }
}
