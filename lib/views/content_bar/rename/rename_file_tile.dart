import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';
import 'package:once_power/widgets/content_bar/normal_tile.dart';
import 'package:once_power/widgets/content_bar/select_sort_card.dart';

class RenameFileTile extends ConsumerWidget {
  const RenameFileTile({super.key, required this.files, required this.file});

  final List<FileInfo> files;
  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectSortCard(
      files: files,
      file: file,
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
    );
  }
}
