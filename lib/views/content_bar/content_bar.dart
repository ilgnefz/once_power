import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/content_bar/top_title_bar.dart';

import 'content_file_tile.dart';

class ContentBar extends StatelessWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            const TopTitleBar(),
            Consumer(
              builder: (context, ref, child) {
                void dropAdd(DropDoneDetails details) {
                  List<XFile> files = details.files;
                  if (files.isNotEmpty) xFileFormat(ref, files);
                }

                List<RenameFile> files = ref.watch(sortListProvider);
                void reorderList(int oldIndex, int newIndex) {
                  if (newIndex > oldIndex) newIndex -= 1;
                  RenameFile item = files.removeAt(oldIndex);
                  files.insert(newIndex, item);
                  updateName(ref);
                  updateExtension(ref);
                }

                return Expanded(
                  child: DropTarget(
                    onDragDone: dropAdd,
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      itemCount: files.length,
                      onReorder: (oldIndex, newIndex) =>
                          reorderList(oldIndex, newIndex),
                      itemBuilder: (context, index) {
                        return ReorderableDragStartListener(
                          index: index,
                          key: ValueKey(files[index].id),
                          child: ContentFileTile(file: files[index]),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
