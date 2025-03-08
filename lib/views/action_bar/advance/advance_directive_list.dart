import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';

import 'advance_list_item.dart';
import 'empty_list.dart';

class AdvanceDirectiveList extends ConsumerWidget {
  const AdvanceDirectiveList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);

    void reorderList(int oldIndex, int newIndex) {
      if (newIndex > oldIndex) newIndex -= 1;
      AdvanceMenuModel item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      advanceUpdateName(ref);
      ref.read(advanceMenuListProvider.notifier).setList(list);
    }

    if (list.isEmpty) return EmptyList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNum.mediumG),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ReorderableListView.builder(
          itemCount: list.length,
          buildDefaultDragHandles: false,
          onReorder: reorderList,
          proxyDecorator: (child, index, animation) {
            return Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(AppNum.smallG),
              child: child,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return ReorderableDragStartListener(
              index: index,
              key: ValueKey(list[index].id),
              child: AdvanceListItem(list[index]),
            );
          },
        ),
      ),
    );
  }
}
