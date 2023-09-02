import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/content_bar/arrange/arrange_file_tile.dart';

import 'arrange/arrange_title_bar.dart';
import 'empty.dart';
import 'rename/rename_file_tile.dart';
import 'rename/rename_title_bar.dart';

class ContentBar extends ConsumerWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void dropAdd(DropDoneDetails details) {
      List<XFile> files = details.files;
      if (files.isNotEmpty) xFileFormat(ref, files);
    }

    List<FileInfo> files = ref.watch(sortListProvider);
    void reorderList(int oldIndex, int newIndex) {
      if (newIndex > oldIndex) newIndex -= 1;
      FileInfo item = files.removeAt(oldIndex);
      files.insert(newIndex, item);
      FunctionMode mode = ref.watch(currentModeProvider);
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

    FunctionMode mode = ref.watch(currentModeProvider);

    return Expanded(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: AppNum.fileCardH,
              child: mode == FunctionMode.organize
                  ? const ArrangeTitleBar()
                  : const RenameTitleBar(),
            ),
            Expanded(
              child: DropTarget(
                onDragDone: dropAdd,
                child: files.isEmpty
                    ? const EmptyView()
                    : ReorderableListView.builder(
                        buildDefaultDragHandles: false,
                        itemCount: files.length,
                        onReorder: (oldIndex, newIndex) =>
                            reorderList(oldIndex, newIndex),
                        itemBuilder: (context, index) {
                          return ReorderableDragStartListener(
                            index: index,
                            key: ValueKey(files[index].id),
                            child: mode == FunctionMode.organize
                                ? ArrangeFileTile(files[index])
                                : RenameFileTile(files[index]),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
