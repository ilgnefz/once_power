import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/sort.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/context/sort_select_item.dart';

import 'item.dart';

class ContentListView extends ConsumerWidget {
  const ContentListView(this.files, {super.key});

  final List<FileInfo> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FileList provider = ref.read(fileListProvider.notifier);
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
        String title = file.name, subtitle = file.newName;
        String ext = file.extension, newExt = file.newExtension;
        Color? subColor = title == subtitle ? Colors.grey : theme.primaryColor;

        if (ref.watch(currentModeProvider).isOrganize) {
          subtitle = file.parent;
          subColor = null;
        }

        if (ref.watch(isDateModifyProvider)) subtitle = '';

        return ReorderableDragStartListener(
          index: index,
          key: ValueKey(file.id),
          child: SortSelectItem(
            index: index,
            file: file,
            onTap: () {},
            child: ContentItem(
              checked: file.checked,
              onChanged: (bool? value) {
                provider.updateCheck(file.id, value!);
                updateName(ref);
              },
              title: title,
              subTitle: subtitle,
              subColor: subColor,
              fontSize: 13,
              action: BaseText(
                newExt,
                fontSize: 13,
                maxLines: 2,
                textAlign: .center,
                overflow: TextOverflow.ellipsis,
                color: ext == newExt ? Colors.grey : theme.primaryColor,
              ),
              icon: Icons.delete_outline_rounded,
              onDelete: () => provider.remove(file),
            ),
          ),
        );
      },
    );
  }
}
