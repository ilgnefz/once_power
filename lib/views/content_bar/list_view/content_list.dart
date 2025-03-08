import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/views/content_bar/grid_view/content_grid.dart';
import 'package:once_power/views/content_bar/list_view/content_list_item.dart';
import 'package:once_power/views/content_bar/empty_content.dart';
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
            // child: isOrganize
            //     ? OrganizeFileTile(files[index])
            //     : RenameFileTile(file: files[index], files: files),
          );
        },
      ),
    );
  }
}
