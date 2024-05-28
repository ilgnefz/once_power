import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/context_menu.dart';
import 'package:once_power/widgets/custom_scrollbar.dart';

import '../rename_tile_tooltip.dart';
import 'image_view_tile.dart';

class ImageGridView extends ConsumerWidget {
  const ImageGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> files = ref.watch(sortListProvider);
    final String selectLabel = S.of(context).select;
    final String unselectLabel = S.of(context).unselect;
    final String deleteLabel = S.of(context).delete;

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
            String id = files[index].id;
            bool checked = files[index].checked;

            return RenameTileTooltip(
              key: ValueKey(id),
              file: files[index],
              waitDuration: const Duration(seconds: 1),
              child: CustomContextMenu(
                menu: Column(
                  children: [
                    MenuContextItem(
                      label: checked ? unselectLabel : selectLabel,
                      color: checked ? Colors.grey : Colors.black,
                      callback: () => toggleCheck(ref, id),
                    ),
                    MenuContextItem(
                      label: deleteLabel,
                      color: Colors.red,
                      callback: () => deleteOne(ref, id),
                    ),
                  ],
                ),
                child: ImageViewTile(files[index]),
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
          insertDuration: const Duration(milliseconds: 150),
          removeDuration: const Duration(milliseconds: 150),
          onReorder: (oldIndex, newIndex) => reorderList(oldIndex, newIndex),
        ),
      ),
    );
  }
}

class MenuContextItem extends StatelessWidget {
  const MenuContextItem({
    super.key,
    required this.label,
    this.color = Colors.black,
    required this.callback,
  });

  final String label;
  final Color color;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        callback();
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: color)),
      ),
    );
  }
}
