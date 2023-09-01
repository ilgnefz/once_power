import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/content_bar/empty.dart';
import 'package:once_power/views/content_bar/organize_file_tile.dart';
import 'package:once_power/views/content_bar/organize_title_bar.dart';
import 'package:once_power/views/content_bar/rename_title_bar.dart';

import 'rename_file_tile.dart';

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
                  ? const OrganizeTitleBar()
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
                                ? OrganizeFileTile(files[index])
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
