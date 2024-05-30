import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/context_menu.dart';
import 'package:once_power/widgets/custom_scrollbar.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../rename_tile_tooltip.dart';
import 'view_mode_tile.dart';

class ViewGridView extends ConsumerWidget {
  const ViewGridView({super.key});

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
        child: ReorderableGridView.extent(
          controller: controller,
          padding: const EdgeInsets.only(right: AppNum.contentRP),
          onReorder: reorderList,
          maxCrossAxisExtent: AppNum.imageW,
          childAspectRatio: 5 / 6,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          proxyDecorator: (child, index, animation) => Container(
            color: Colors.transparent,
            child: child,
          ),
          children: files.map((e) {
            String id = e.id;
            bool checked = e.checked;
            return RenameTileTooltip(
              key: ValueKey(id),
              file: e,
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
                child: ViewModeTile(e),
              ),
            );
          }).toList(),
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
