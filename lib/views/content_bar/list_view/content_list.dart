import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/views/content_bar/list_view/content_list_item.dart';
import 'package:once_power/widgets/content_bar/easy_scrollbar.dart';

class ContentList extends ConsumerWidget {
  const ContentList({super.key, required this.files});

  final List<FileInfo> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController controller = ref.watch(scrollBarControllerProvider);
    return EasyScrollbar(
      controller: controller,
      child: ReorderableListView.builder(
        scrollController: controller,
        itemCount: files.length,
        padding: const EdgeInsets.only(right: AppNum.defaultP),
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          reorderList(ref, files, oldIndex, newIndex);
        },
        proxyDecorator: (proxy, original, information) {
          return Material(
            color: Colors.white,
            elevation: 2,
            borderRadius: BorderRadius.circular(4),
            shadowColor: Colors.black,
            child: proxy,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ReorderableDragStartListener(
            index: index,
            key: ValueKey(files[index].id),
            child: ContentListItem(index: index, file: files[index]),
          );
        },
      ),
    );
  }
}
