import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/advance.dart';
import 'package:once_power/model/advance_menu.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/action_bar/advance/advance_list_item.dart';
import 'package:once_power/widgets/common/click_icon.dart';

import 'empty_list.dart';

class AdvanceList extends ConsumerWidget {
  const AdvanceList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);

    void reorderList(int oldIndex, int newIndex) {
      if (newIndex > oldIndex) newIndex -= 1;
      AdvanceMenuModel item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      advanceUpdateName(ref);
      // ref.read(advanceMenuListProvider.notifier).setList(list);
    }

    if (list.isEmpty) return EmptyList();

    TextStyle textStyle = TextStyle(
      fontSize: 13,
      color: Colors.grey,
    ).useSystemChineseFont();

    return Column(
      children: [
        Container(
          height: 24,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: AppNum.mediumG),
          child: Row(
            children: [
              Text('共 ${list.length} 项', style: textStyle),
              const Spacer(),
              ClickIcon(
                size: 18,
                iconSize: 16,
                icon: Icons.delete_outline_rounded,
                color: Colors.grey,
                onTap: () {
                  ref.read(advanceMenuListProvider.notifier).setList([]);
                  advanceUpdateName(ref);
                },
              )
            ],
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ReorderableListView.builder(
              itemCount: list.length,
              // padding: const EdgeInsets.only(right: AppNum.defaultP),
              buildDefaultDragHandles: false,
              onReorder: reorderList,
              itemBuilder: (BuildContext context, int index) {
                return ReorderableDragStartListener(
                  index: index,
                  key: ValueKey(list[index].id),
                  child: AdvanceListItem(list[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
