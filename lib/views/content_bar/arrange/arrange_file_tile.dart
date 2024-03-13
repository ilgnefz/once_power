import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:once_power/widgets/normal_tile.dart';
import 'package:once_power/widgets/tip_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ArrangeFileTile extends ConsumerWidget {
  const ArrangeFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String name = S.of(context).fileName;
    final String folder = S.of(context).folder;

    String fileName = file.extension == '' || file.type == FileClassify.folder
        ? file.name
        : '${file.name}.${file.extension}';
    String fileFolder =
        file.type == FileClassify.folder ? file.filePath : file.parent;

    void openFolder() async {
      String encodedPath = Uri.encodeComponent(fileFolder);

      if (Platform.isWindows) {
        await Process.run('explorer', [fileFolder]);
      } else {
        final Uri url =
            Uri.parse('file:///${encodedPath.replaceAll(' ', '%20')}');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          debugPrint('无法打开文件夹:$fileFolder');
        }
      }
    }

    return EasyTooltip(
      // margin: const EdgeInsets.only(left: 240),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TipText(label: name, content: fileName),
            TipText(label: folder, content: fileFolder),
          ],
        ),
      ),
      child: Material(
        child: Ink(
          color: Colors.white,
          child: InkWell(
            hoverColor: Theme.of(context).primaryColor.withOpacity(.1),
            onDoubleTap: openFolder,
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
                      file.extension == 'dir' ? '' : file.extension,
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
