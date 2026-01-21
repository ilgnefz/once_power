import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/sort.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/context/item.dart';

class ContentListView extends ConsumerWidget {
  const ContentListView(this.files, {super.key});

  final List<FileInfo> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReorderableListView.builder(
      itemCount: files.length,
      itemExtent: AppNum.topHeight,
      buildDefaultDragHandles: false,
      padding: EdgeInsets.only(right: AppNum.padding),
      proxyDecorator: (proxy, original, information) {
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 2,
          borderRadius: BorderRadius.circular(AppNum.radius),
          shadowColor: Colors.black,
          child: proxy,
        );
      },
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        reorderList(ref, files, oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        FileInfo file = files[index];
        return ReorderableDragStartListener(
          index: index,
          key: ValueKey(file.id),
          child: ContentItem(
            checked: file.checked,
            onChanged: (bool? value) => ref
                .read(fileListProvider.notifier)
                .updateCheck(file.id, value!),
            title: file.name,
            subTitle: file.newName,
            fontSize: 13,
            action: BaseText(file.newExt, fontSize: 13),
            icon: Icons.delete_outline_rounded,
            onDelete: () => ref.read(fileListProvider.notifier).remove(file),
            onTap: () {},
          ),
        );
      },
    );
  }
}
