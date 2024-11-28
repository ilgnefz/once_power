import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/views/content_bar/rename/rename_tile_tooltip.dart';
import 'package:once_power/widgets/common/easy_context_menu.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';
import 'package:once_power/widgets/content_bar/normal_tile.dart';

import 'view_model/view_grid_view.dart';

class RenameFileTile extends ConsumerWidget {
  const RenameFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String matchName = S.of(context).matchName;
    final String modifyName = S.of(context).modifyName;
    final String moveToFirst = S.of(context).moveToFirst;
    final String moveToCenter = S.of(context).moveToCenter;
    final String moveToLast = S.of(context).moveToLast;

    return RenameTileTooltip(
      file: file,
      waitDuration: const Duration(seconds: 1),
      child: EasyContextMenu(
        count: 5,
        menu: Column(
          children: [
            MenuContextItem(
              label: matchName,
              color: Colors.black,
              callback: () => autoMatchInput(ref, file.name),
            ),
            MenuContextItem(
              label: modifyName,
              color: Colors.black,
              callback: () => autoModifyInput(ref, file.name),
            ),
            MenuContextItem(
              label: moveToFirst,
              color: Colors.black,
              callback: () => toTheFirst(ref, file),
            ),
            MenuContextItem(
              label: moveToCenter,
              color: Colors.black,
              callback: () => toTheCenter(ref, file),
            ),
            MenuContextItem(
              label: moveToLast,
              color: Colors.black,
              callback: () => toTheLast(ref, file),
            ),
          ],
        ),
        child: Material(
          child: Ink(
            color: Colors.white,
            child: InkWell(
              hoverColor: Theme.of(context).primaryColor.withOpacity(.1),
              onDoubleTap: () => autoInput(ref, file.name),
              child: Row(
                children: [
                  CheckTile(
                    check: file.checked,
                    label: file.name,
                    fontSize: AppNum.tileFontSize,
                    onChanged: (v) => toggleCheck(ref, file.id),
                    color: Colors.grey,
                  ),
                  NormalTile(
                      label: file.newName, fontSize: AppNum.tileFontSize),
                  SizedBox(
                    width: AppNum.extensionW,
                    child: Center(
                      child: Text(
                        file.newExtension,
                        style: const TextStyle(fontSize: AppNum.tileFontSize),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppNum.deleteBtnS,
                    child: Center(
                      child: IconButton(
                        onPressed: () => deleteOne(ref, file.id),
                        color: Colors.black26,
                        icon: const Icon(Icons.delete_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
