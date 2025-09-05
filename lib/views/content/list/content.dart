import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/views/content/list/item.dart';

class ContentList extends ConsumerWidget {
  const ContentList({super.key, required this.files});

  final List<FileInfo> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: ref.read(sortSelectListProvider.notifier).clear,
      child: ReorderableListView.builder(
        padding: const EdgeInsets.only(right: 12.0),
        cacheExtent: 40,
        itemCount: files.length,
        buildDefaultDragHandles: false,
        proxyDecorator: (proxy, original, information) {
          return Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            borderRadius: BorderRadius.circular(4),
            shadowColor: Colors.black,
            child: proxy,
          );
        },
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          reorderList(ref, files, oldIndex, newIndex);
        },
        itemBuilder: (_, index) {
          final FileInfo file = files[index];
          return ReorderableDragStartListener(
            index: index,
            key: ValueKey(file.id),
            child: ContentListItem(index: index, file: file),
          );
        },
      ),
    );
  }
}
