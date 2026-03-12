import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/list.dart';

import 'empty.dart';
import 'item.dart';

class DirectiveList extends ConsumerWidget {
  const DirectiveList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);
    if (list.isEmpty) return DirectiveEmpty();
    return ReorderableListView.builder(
      itemCount: list.length,
      itemExtent: AppNum.directiveHeight,
      buildDefaultDragHandles: false,
      padding: .symmetric(horizontal: AppNum.spaceMedium),
      proxyDecorator: (child, index, animation) {
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 2,
          borderRadius: BorderRadius.circular(AppNum.radiusSmall),
          child: child,
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        AdvanceMenuModel item = list.removeAt(oldIndex);
        list.insert(newIndex, item);
        advanceUpdateName(ref);
        ref.read(advanceMenuListProvider.notifier).setList(list);
        ref.read(advanceMenuSelectedListProvider.notifier).clear();
      },
      itemBuilder: (BuildContext context, int index) {
        return ReorderableDragStartListener(
          key: ValueKey(list[index].id),
          index: index,
          child: DirectiveItem(menu: list[index]),
        );
      },
    );
  }
}
