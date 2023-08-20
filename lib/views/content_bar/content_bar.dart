import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/get_file.dart';
import 'package:once_power/views/content_bar/top_title_bar.dart';

import 'content_file_title.dart';

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
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  List<RenameFile> files = ref.watch(fileListProvider);

                  void reorderList(int oldIndex, int newIndex) {
                    if (newIndex > oldIndex) newIndex -= 1;
                    RenameFile item = files.removeAt(oldIndex);
                    files.insert(newIndex, item);
                  }

                  return ReorderableListView.builder(
                    buildDefaultDragHandles: false,
                    itemCount: files.length,
                    onReorder: (oldIndex, newIndex) =>
                        reorderList(oldIndex, newIndex),
                    itemBuilder: (context, index) {
                      return ReorderableDragStartListener(
                        index: index,
                        key: ValueKey(files[index].id),
                        child: ContentFileTitle(file: files[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
