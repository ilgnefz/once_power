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
        final ThemeData theme = Theme.of(context);
        final String name = file.name, newName = file.newName;
        final String ext = file.ext, newExt = file.newExt;
        return ReorderableDragStartListener(
          index: index,
          key: ValueKey(file.id),
          child: ContentItem(
            checked: file.checked,
            onChanged: (bool? value) => ref
                .read(fileListProvider.notifier)
                .updateCheck(file.id, value!),
            title: name,
            subTitle: newName,
            subColor: name == newName ? Colors.grey : theme.primaryColor,
            fontSize: 13,
            action: BaseText(
              newExt,
              fontSize: 13,
              color: ext == newExt ? Colors.grey : theme.primaryColor,
            ),
            icon: Icons.delete_outline_rounded,
            onDelete: () => ref.read(fileListProvider.notifier).remove(file),
            onTap: () {},
          ),
        );
      },
    );
  }
}
