import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/input.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';

import 'right_menu_item.dart';

class RightClickMenu extends ConsumerWidget {
  const RightClickMenu({
    super.key,
    required this.width,
    // required this.height,
    required this.x,
    required this.y,
    required this.file,
    required this.show,
  });

  final double width;
  // final double height;
  final double x;
  final double y;
  final FileInfo file;
  final bool show;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UnconstrainedBox(
      alignment: Alignment.topLeft,
      child: Container(
        width: width,
        // height: height,
        margin: EdgeInsets.only(left: x, top: y),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black.withValues(alpha: .2),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              RightMenuItem(
                label: S.of(context).openPosition,
                color: Colors.black,
                callback: () => openFileLocation(file.filePath),
              ),
              if (show)
                RightMenuItem(
                  label: S.of(context).matchName,
                  color: Colors.black,
                  callback: () => autoMatchInput(ref, file.name),
                ),
              if (show)
                RightMenuItem(
                  label: S.of(context).modifyName,
                  color: Colors.black,
                  callback: () => autoModifyInput(ref, file.name),
                ),
              RightMenuItem(
                label: S.of(context).moveToFirst,
                color: Colors.black,
                callback: () => toTheFirst(ref),
              ),
              RightMenuItem(
                label: S.of(context).moveToCenter,
                color: Colors.black,
                callback: () => toTheCenter(ref),
              ),
              RightMenuItem(
                label: S.of(context).moveToLast,
                color: Colors.black,
                callback: () => toTheLast(ref),
              ),
              if (ref.watch(currentModeProvider).isOrganize)
                RightMenuItem(
                  label: S.of(context).matchParent,
                  color: Colors.black,
                  callback: () => ref
                      .read(folderControllerProvider.notifier)
                      .updateText(file.parent),
                ),
              RightMenuItem(
                label: file.checked
                    ? S.of(context).unselect
                    : S.of(context).select,
                color: file.checked ? Colors.grey : Colors.black,
                callback: () => toggleCheck(ref, file.id),
              ),
              RightMenuItem(
                label: S.of(context).removeFolder,
                color: Colors.red,
                callback: () => removeFolder(ref, file.parent),
              ),
              RightMenuItem(
                label: S.of(context).remove,
                color: Colors.red,
                callback: () => removeOne(ref, file.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
