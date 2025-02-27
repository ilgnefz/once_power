import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/easy_scroll_bar.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import 'view_mode_tile.dart';

class ViewGridView extends ConsumerWidget {
  const ViewGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController controller = ref.watch(scrollBarControllerProvider);
    List<FileInfo> files = ref.watch(sortListProvider);

    void reorderList(int oldIndex, int newIndex) {
      // if (newIndex > oldIndex) newIndex -= 1;
      FileInfo item = files.removeAt(oldIndex);
      files.insert(newIndex, item);
      ref.read(fileListProvider.notifier).addAll(files);
      ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
      updateName(ref);
      updateExtension(ref);
    }

    return GestureDetector(
      onTap: ref.read(sortSelectListProvider.notifier).clear,
      child: LayoutBuilder(
        builder: (context, constraints) => EasyScrollbar(
          controller: controller,
          child: ReorderableGridView.extent(
            controller: controller,
            padding: const EdgeInsets.only(right: AppNum.defaultP),
            onReorder: reorderList,
            maxCrossAxisExtent: AppNum.imageW,
            childAspectRatio: 5 / 6,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            proxyDecorator: (child, index, animation) => Container(
              color: Colors.transparent,
              child: child,
            ),
            children: files.map((e) {
              return ViewModeTile(files, e, key: ValueKey(e.id));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
