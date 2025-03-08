import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/input.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';

import 'right_menu_item.dart';

class RightClickMenu extends ConsumerWidget {
  const RightClickMenu({
    super.key,
    required this.width,
    required this.height,
    required this.x,
    required this.y,
    required this.e,
  });

  final double width;
  final double height;
  final double x;
  final double y;
  final FileInfo e;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UnconstrainedBox(
      alignment: Alignment.topLeft,
      child: Container(
        width: width,
        height: height,
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
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              RightMenuItem(
                label: S.of(context).openPosition,
                color: Colors.black,
                callback: () => openFileLocation(e.filePath),
              ),
              RightMenuItem(
                label: S.of(context).matchName,
                color: Colors.black,
                callback: () => autoMatchInput(ref, e.name),
              ),
              RightMenuItem(
                label: S.of(context).modifyName,
                color: Colors.black,
                callback: () => autoModifyInput(ref, e.name),
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
              RightMenuItem(
                label:
                    e.checked ? S.of(context).unselect : S.of(context).select,
                color: e.checked ? Colors.grey : Colors.black,
                callback: () {
                  for (var f in ref.watch(sortSelectListProvider)) {
                    toggleCheck(ref, f.id);
                  }
                },
              ),
              RightMenuItem(
                label: S.of(context).remove,
                color: Colors.red,
                callback: () {
                  for (var f in ref.watch(sortSelectListProvider)) {
                    removeOne(ref, f.id);
                    ref.read(sortSelectListProvider.notifier).remove(f);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
