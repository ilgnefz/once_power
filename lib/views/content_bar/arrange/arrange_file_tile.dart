import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:once_power/widgets/normal_tile.dart';
import 'package:once_power/widgets/tip_text.dart';

class ArrangeFileTile extends ConsumerWidget {
  const ArrangeFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String name = '名称';
    const String folder = '文件夹';

    String fileName = file.extension == '' || file.type == FileClassify.folder
        ? file.name
        : '${file.name}.${file.extension}';
    String fileFolder =
        file.type == FileClassify.folder ? file.filePath : file.parent;

    return EasyTooltip(
      margin: const EdgeInsets.only(left: 240),
      richMessage: WidgetSpan(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TipText(label: name, content: fileName),
              TipText(label: folder, content: fileFolder),
            ],
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        child: Ink(
          color: Colors.white,
          child: InkWell(
            hoverColor: Theme.of(context).primaryColor.withOpacity(.1),
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(width: AppNum.gapW),
                Icon(
                  getFileIcon(file.extension),
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                NormalTile(label: fileName, fontSize: AppNum.tileFontSize),
                NormalTile(label: fileFolder, fontSize: AppNum.tileFontSize),
                SizedBox(
                  width: AppNum.deleteW,
                  child: Center(
                    child: Text(
                      file.extension,
                      style: const TextStyle(fontSize: AppNum.tileFontSize),
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
