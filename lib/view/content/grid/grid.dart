import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/sort.dart';
import 'package:once_power/model/file.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import 'item.dart';

class ContentGridView extends ConsumerWidget {
  const ContentGridView(this.files, {super.key});

  final List<FileInfo> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReorderableGridView.extent(
      padding: const EdgeInsets.only(right: AppNum.padding),
      onReorder: (oldIndex, newIndex) =>
          reorderList(ref, files, oldIndex, newIndex),
      // maxCrossAxisExtent: ref.watch(viewImageWidthProvider),
      maxCrossAxisExtent: 136,
      childAspectRatio: 5 / 6,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      proxyDecorator: (child, index, animation) => Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4),
        elevation: 2,
        child: child,
      ),
      children: files.map((e) {
        int index = files.indexOf(e);
        return ContentGridItem(key: ValueKey(e.id), index: index, file: e);
      }).toList(),
    );
  }
}
