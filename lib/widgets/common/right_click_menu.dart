import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';

import 'menu_context_item.dart';

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
    final String selectLabel = S.of(context).select;
    final String unselectLabel = S.of(context).unselect;
    final String removeLabel = S.of(context).remove;
    final String matchName = S.of(context).matchName;
    final String modifyName = S.of(context).modifyName;
    final String moveToFirst = S.of(context).moveToFirst;
    final String moveToCenter = S.of(context).moveToCenter;
    final String moveToLast = S.of(context).moveToLast;

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
              MenuContextItem(
                label: matchName,
                color: Colors.black,
                callback: () => autoMatchInput(ref, e.name),
              ),
              MenuContextItem(
                label: modifyName,
                color: Colors.black,
                callback: () => autoModifyInput(ref, e.name),
              ),
              MenuContextItem(
                label: moveToFirst,
                color: Colors.black,
                callback: () => toTheFirst(ref),
              ),
              MenuContextItem(
                label: moveToCenter,
                color: Colors.black,
                callback: () => toTheCenter(ref),
              ),
              MenuContextItem(
                label: moveToLast,
                color: Colors.black,
                callback: () => toTheLast(ref),
              ),
              MenuContextItem(
                label: e.checked ? unselectLabel : selectLabel,
                color: e.checked ? Colors.grey : Colors.black,
                callback: () {
                  for (var f in ref.watch(sortSelectListProvider)) {
                    toggleCheck(ref, f.id);
                  }
                },
              ),
              MenuContextItem(
                label: removeLabel,
                color: Colors.red,
                callback: () {
                  for (var f in ref.watch(sortSelectListProvider)) {
                    deleteOne(ref, f.id);
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
