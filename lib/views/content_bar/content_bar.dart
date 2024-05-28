import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/views/content_bar/rename/image_view/image_grid_view.dart';
import 'package:once_power/widgets/custom_scrollbar.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import 'empty.dart';
import 'arrange/arrange_file_tile.dart';
import 'arrange/arrange_title_bar.dart';
import 'rename/image_view/image_view_title_bar.dart';
import 'rename/rename_file_tile.dart';
import 'rename/rename_title_bar.dart';

class ContentBar extends ConsumerWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> files = ref.watch(sortListProvider);
    FunctionMode mode = ref.watch(currentModeProvider);
    bool isOrganize = mode == FunctionMode.organize;
    bool isImageView = ref.watch(imageViewProvider);

    void dropAdd(DropDoneDetails details) {
      List<XFile> files = details.files;
      if (files.isNotEmpty) {
        ref.read(totalProvider.notifier).update(files.length);
        formatXFile(ref, files);
      }
    }

    void reorderList(int oldIndex, int newIndex) {
      // if (newIndex > oldIndex) newIndex -= 1;
      FileInfo item = files.removeAt(oldIndex);
      files.insert(newIndex, item);
      FunctionMode mode = ref.watch(currentModeProvider);
      // modify
      ref.read(fileListProvider.notifier).addAll(files);
      ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
      // ref.read(provider)
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
                  : isImageView
                      ? const ImageViewTitleBar()
                      : const RenameTitleBar(),
            ),
            Expanded(
              child: DropTarget(
                onDragDone: dropAdd,
                child: BuildListView(
                  files: files,
                  isImageView: isImageView,
                  isOrganize: isOrganize,
                  onReorder: reorderList,
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
    required this.files,
    required this.isImageView,
    required this.isOrganize,
    required this.onReorder,
  });

  final List<FileInfo> files;
  final bool isImageView;
  final bool isOrganize;
  final void Function(int, int) onReorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (files.isEmpty) return const EmptyView();
    if (isImageView && !isOrganize) return const ImageGridView();

    ScrollController controller = ref.watch(scrollBarControllerProvider);

    return CustomScrollbar(
      controller: controller,
      child: AnimatedReorderableListView(
        controller: controller,
        items: files,
        padding: const EdgeInsets.only(right: AppNum.contentRP),
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          if (isOrganize) {
            return ArrangeFileTile(
              files[index],
              key: ValueKey(files[index].id),
            );
          }
          return RenameFileTile(
            files[index],
            key: ValueKey(files[index].id),
          );
        },
        enterTransition: [FlipInX(), ScaleIn()],
        exitTransition: [SlideInLeft()],
        insertDuration: const Duration(milliseconds: 300),
        removeDuration: const Duration(milliseconds: 300),
        onReorder: onReorder,
        // onReorderStart: (v) {
        //   print('开始了：$v');
        // },
        // onReorderEnd: (v) {
        //   print('结束了：$v');
        // },
      ),
    );
  }
}

// TODO 删除
// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     super.key,
//     required this.files,
//     required this.mode,
//   });
//
//   final List<FileInfo> files;
//   final FunctionMode mode;
//
//   @override
//   Widget build(BuildContext context) {
//     return ReorderableListView.builder(
//         buildDefaultDragHandles: false,
//         itemCount: files.length,
//         onReorder: (oldIndex, newIndex) => reorderList(oldIndex, newIndex),
//         itemBuilder: (context, index) {
//           return ReorderableDragStartListener(
//             index: index,
//             key: ValueKey(files[index].id),
//             child: mode == FunctionMode.organize ? ArrangeFileTile(files[index]) : RenameFileTile(files[index]),
//           );
//         },
//       );
//   }
// }
