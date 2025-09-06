import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/views/action/advance/empty.dart';

import 'item.dart';

class DirectiveList extends ConsumerWidget {
  const DirectiveList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);

    if (list.isEmpty) return DirectiveEmpty();

    void reorderList(int oldIndex, int newIndex) {
      if (newIndex > oldIndex) newIndex -= 1;
      AdvanceMenuModel item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      advanceUpdateName(ref);
      ref.read(advanceMenuListProvider.notifier).setList(list);
      ref.read(advanceMenuSelectedListProvider.notifier).clear();
    }

    return GestureDetector(
      onTap: ref.read(advanceMenuSelectedListProvider.notifier).clear,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ReorderableListView.builder(
            itemCount: list.length,
            buildDefaultDragHandles: false,
            onReorder: reorderList,
            proxyDecorator: (child, index, animation) {
              return Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 2,
                borderRadius: BorderRadius.circular(AppNum.spaceSmall),
                child: child,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return ReorderableDragStartListener(
                index: index,
                key: ValueKey(list[index].id),
                child: AdvanceListItem(index: index, menu: list[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
