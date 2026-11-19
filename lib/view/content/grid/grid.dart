import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_multi_select_reorder/flutter_multi_select_reorder.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/controller.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widget/content/selected.dart';

import 'item.dart';

/// 只在 grid 里显示的图片类型；其余文件留在 list 里。
const Set<String> _imageExtensions = <String>{
  'jpg',
  'jpeg',
  'png',
  'gif',
  'webp',
  'bmp',
  'heic',
};

bool _isImage(FileInfo file) =>
    _imageExtensions.contains(file.newExtension.toLowerCase());

class ContentGridView extends ConsumerWidget {
  const ContentGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // grid 只显示图片，是 sortListProvider 的子集；下标与 list 不再对齐，
    // 所以必须给组件传稳定 id（file.id），选中才能跨视图保留。
    final List<FileInfo> all = ref.watch(sortListProvider);
    final List<FileInfo> files = all.where(_isImage).toList();
    return MultiSelectReorder.grid(
      controller: ref.watch(selectionControllerProvider),
      padding: .only(right: AppNumber.padding),
      itemCount: files.length,
      maxCellWidth: AppNumber.gridCellWidth,
      mainAxisExtent: AppNumber.gridCellWidth * 6 / 5,
      aspectRatio: 5 / 6,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      onDoubleTap: (int i) => showPreviewView(context, i),
      onSecondaryTap: (index, globalPosition) {},
      itemKeyBuilder: (index) => ValueKey<String>(files[index].id),
      itemId: (index) => files[index].id,
      itemBuilder: (_, int index, bool _) =>
          ContentGridItem(file: files[index]),
      onReorder: (List<int> oldIndices, List<int> newIndices) {
        // 组件回传的是**过滤后**的下标。只重排图片占的那些全量槽位，
        // 非图片项留在原位。
        final List<int> slots = <int>[
          for (int i = 0; i < all.length; i++)
            if (_isImage(all[i])) i,
        ];
        ref
            .read(fileListProvider.notifier)
            .reorderAtSlots(slots, oldIndices, newIndices);
      },
      style: MultiSelectStyle(
        doubleTapMode: MultiSelectDoubleTapMode.selectOnly,
        mouseCursor: SystemMouseCursors.click,
        borderRadius: .circular(AppNumber.radius),
        selectedBuilder: (child, index, selectedIndex, selectedCount) =>
            SelectedItem(
              index: selectedCount > 1 ? selectedIndex : null,
              child: child,
            ),
        placeholderColor: Colors.transparent,
        placeholderBuilder: (_) => const SizedBox.shrink(),
      ),
    );
  }
}
