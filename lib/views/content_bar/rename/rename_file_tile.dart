import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/views/content_bar/rename/rename_tile_tooltip.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';
import 'package:once_power/widgets/content_bar/normal_tile.dart';

class RenameFileTile extends ConsumerWidget {
  const RenameFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSecondaryTapDown(TapDownDetails details) async {
      await showRightMenu(context, ref, details, file);
    }

    return RenameTileTooltip(
      file: file,
      waitDuration: const Duration(seconds: 1),
      child: Material(
        child: Ink(
          color: Colors.white,
          child: InkWell(
            hoverColor: Theme.of(context).primaryColor.withValues(alpha: .1),
            onDoubleTap: () => autoInput(ref, file.name),
            onSecondaryTapDown: onSecondaryTapDown,
            child: Row(
              children: [
                CheckTile(
                  check: file.checked,
                  label: file.name,
                  fontSize: AppNum.tileFontSize,
                  onChanged: (v) => toggleCheck(ref, file.id),
                  color: Colors.grey,
                ),
                NormalTile(label: file.newName, fontSize: AppNum.tileFontSize),
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
    );
  }
}
