import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/views/content_bar/grid_view/content_grid_item.dart';
import 'package:once_power/widgets/content_bar/easy_scrollbar.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class ContentGrid extends ConsumerWidget {
  const ContentGrid({super.key, required this.files});

  final List<FileInfo> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController controller = ref.watch(scrollBarControllerProvider);

    return GestureDetector(
      onTap: ref.read(sortSelectListProvider.notifier).clear,
      child: EasyScrollbar(
        controller: controller,
        child: ReorderableGridView.extent(
          controller: controller,
          padding: const EdgeInsets.only(right: AppNum.defaultP),
          onReorder: (oldIndex, newIndex) =>
              reorderList(ref, files, oldIndex, newIndex),
          maxCrossAxisExtent: AppNum.imageW,
          childAspectRatio: 5 / 6,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          proxyDecorator: (child, index, animation) => Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            elevation: 2,
            child: child,
          ),
          children: files.map((e) {
            return ContentGridItem(key: ValueKey(e.id), file: e, files: files);
          }).toList(),
        ),
      ),
    );
  }
}
