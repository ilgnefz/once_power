import 'dart:io';

import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/context_menu.dart';
import 'package:once_power/widgets/custom_scrollbar.dart';

import 'image_preview.dart';

class ImageGridView extends ConsumerWidget {
  const ImageGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> files = ref.watch(sortListProvider);

    void reorderList(int oldIndex, int newIndex) {
      // if (newIndex > oldIndex) newIndex -= 1;
      FileInfo item = files.removeAt(oldIndex);
      files.insert(newIndex, item);
      ref.read(fileListProvider.notifier).addAll(files);
      ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
      updateName(ref);
      updateExtension(ref);
    }

    ScrollController controller = ref.watch(scrollBarControllerProvider);

    return LayoutBuilder(
      builder: (context, constraints) => CustomScrollbar(
        controller: controller,
        child: AnimatedReorderableGridView(
          controller: controller,
          items: files,
          padding: const EdgeInsets.only(right: AppNum.contentRP),
          itemBuilder: (BuildContext context, int index) {
            return MyContextMenu(
              key: ValueKey(files[index].id),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  // TODO ???
                  onTap: () {},
                  onDoubleTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ImagePreview(files[index].filePath),
                    );
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.file(
                            File(files[index].filePath),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fileName(
                            files[index].newName,
                            files[index].newExtension,
                          ),
                          style: const TextStyle(fontSize: AppNum.tileFontSize),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          sliverGridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (constraints.maxWidth / 120).floor(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 5 / 6,
          ),
          enterTransition: [FadeIn(), ScaleIn()],
          // exitTransition:  [SlideIn()],
          insertDuration: const Duration(milliseconds: 300),
          removeDuration: const Duration(milliseconds: 300),
          onReorder: (oldIndex, newIndex) => reorderList(oldIndex, newIndex),
        ),
      ),
    );
  }
}
