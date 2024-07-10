import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/custom_scrollbar.dart';

import 'empty.dart';
import 'arrange/arrange_file_tile.dart';
import 'arrange/arrange_title_bar.dart';
import 'rename/rename_file_tile.dart';
import 'rename/rename_title_bar.dart';
import 'rename/view_mode/view_grid_view.dart';
import 'rename/view_mode/view_mode_title_bar.dart';

class ContentBar extends ConsumerWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FunctionMode mode = ref.watch(currentModeProvider);
    bool isOrganize = mode == FunctionMode.organize;
    bool isViewMode = ref.watch(viewModeProvider);

    void dropAdd(DropDoneDetails details) {
      List<XFile> files = details.files;
      if (files.isNotEmpty) {
        ref.read(totalProvider.notifier).update(files.length);
        formatXFile(ref, files);
      }
    }

    return Expanded(
      child: Container(
        // padding: const EdgeInsets.only(right: 4),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: AppNum.fileCardH,
              child: isOrganize
                  ? const ArrangeTitleBar()
                  : isViewMode
                      ? const ViewModeTitleBar()
                      : const RenameTitleBar(),
            ),
            Expanded(
              child: DropTarget(
                onDragDone: dropAdd,
                child: BuildListView(
                  isViewMode: isViewMode,
                  isOrganize: isOrganize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildListView extends ConsumerWidget {
  const BuildListView({
    super.key,
    required this.isViewMode,
    required this.isOrganize,
  });

  final bool isViewMode;
  final bool isOrganize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> files = ref.watch(sortListProvider);
    if (files.isEmpty) return const EmptyView();
    if (isViewMode && !isOrganize) return const ViewGridView();

    ScrollController controller = ref.watch(scrollBarControllerProvider);

    void reorderList(int oldIndex, int newIndex) {
      if (newIndex > oldIndex) newIndex -= 1;
      FileInfo item = files.removeAt(oldIndex);
      files.insert(newIndex, item);
      FunctionMode mode = ref.watch(currentModeProvider);
      ref.read(fileListProvider.notifier).addAll(files);
      ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
      if (mode == FunctionMode.organize) {
        TextEditingController controller = ref.watch(targetControllerProvider);
        bool isFile = files.first.extension != 'dir';
        if (controller.text.isEmpty) {
          controller.text = isFile ? files.first.parent : files.first.filePath;
        }
      }
      updateName(ref);
      updateExtension(ref);
    }

    return CustomScrollbar(
      controller: controller,
      child: ReorderableListView.builder(
        scrollController: controller,
        itemCount: files.length,
        padding: const EdgeInsets.only(right: AppNum.contentRP),
        buildDefaultDragHandles: false,
        onReorder: reorderList,
        itemBuilder: (BuildContext context, int index) {
          return ReorderableDragStartListener(
            index: index,
            key: ValueKey(files[index].id),
            child: isOrganize
                ? ArrangeFileTile(files[index])
                : RenameFileTile(files[index]),
          );
        },
      ),
    );
  }
}
