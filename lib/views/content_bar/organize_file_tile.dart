import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widgets/normal_tile.dart';

class OrganizeFileTile extends ConsumerWidget {
  const OrganizeFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Ink(
        color: Colors.white,
        child: InkWell(
          hoverColor: Theme.of(context).primaryColor.withOpacity(.1),
          onTap: () {},
          child: Row(
            children: [
              const SizedBox(width: 8),
              Icon(
                getFileIcon(file.extension),
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              NormalTile(
                label: file.extension == '' || file.type == FileClassify.folder
                    ? file.name
                    : '${file.name}.${file.extension}',
                fontSize: 12,
              ),
              SizedBox(
                width: AppNum.deleteW,
                child: Center(
                  child: Text(
                    file.type.value,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                width: AppNum.deleteW,
                child: Center(
                  child: IconButton(
                    onPressed: () =>
                        ref.read(fileListProvider.notifier).remove(file.id),
                    color: Colors.black26,
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData getFileIcon(String extension) {
  if (folder.contains(extension)) return Icons.folder_rounded;
  if (image.contains(extension)) return Icons.image_rounded;
  if (video.contains(extension)) return Icons.movie_creation_rounded;
  if (text.contains(extension)) return Icons.text_snippet_rounded;
  if (audio.contains(extension)) return Icons.audiotrack_rounded;
  if (zip.contains(extension)) return Icons.backpack_rounded;
  return Icons.question_mark_rounded;
}
