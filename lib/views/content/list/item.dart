import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/base/one_line_text.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/content/select_sort_item.dart';

class ContentListItem extends ConsumerWidget {
  const ContentListItem({super.key, required this.index, required this.file});

  final int index;
  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    bool isOrganize = ref.watch(currentModeProvider).isOrganize;
    bool changeNameStyle = file.name == file.newName;
    bool changeExtStyle = isOrganize || file.ext == file.newExt;
    return SelectSortItem(
      index: index,
      file: file,
      onDoubleTap: () {},
      child: Container(
        height: 40,
        padding: EdgeInsets.only(left: 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            EasyCheckbox(
              label: '',
              checked: file.checked,
              onChanged: () {
                final FileList fileList = ref.read(fileListProvider.notifier);
                fileList.updateCheck(file.id, !file.checked);
                Debounce.run(() => updateName(ref));
              },
            ),
            OneLineText(file.name, fontSize: 13),
            SizedBox(width: 8),
            OneLineText(
              isOrganize ? file.parent : file.newName,
              flex: ref.watch(expandNewNameProvider) ? 2 : 1,
              fontSize: 13,
              color: isOrganize
                  ? Colors.black
                  : changeNameStyle
                  ? Colors.grey
                  : theme.primaryColor,
            ),
            SizedBox(width: 8),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                file.newExt,
                style: TextStyle(
                  fontSize: 13,
                  color: isOrganize
                      ? Colors.black
                      : changeExtStyle
                      ? Colors.grey
                      : theme.primaryColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ClickIcon(
              icon: Icons.delete_outline_rounded,
              onPressed: () {
                ref.read(fileListProvider.notifier).remove(file);
                updateName(ref);
              },
            ),
          ],
        ),
      ),
    );
  }
}
