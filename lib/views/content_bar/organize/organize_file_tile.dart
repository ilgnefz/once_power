import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/widgets/common/custom_tooltip.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';
import 'package:once_power/widgets/content_bar/normal_tile.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizeFileTile extends ConsumerWidget {
  const OrganizeFileTile(this.file, {super.key});

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

    void setTargetFolder() {
      TextEditingController controller = ref.watch(targetControllerProvider);
      controller.text = file.parent;
      targetFolderCache(ref, file.parent);
    }

    void openFolder() async {
      if (!Platform.isWindows) return;

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
      placement: Placement.bottom,
      waitDuration: const Duration(seconds: 1),
      richMessage: TextSpan(
        children: [
          richTextTooltip(context, name, fileName),
          richTextTooltip(context, folder, fileFolder, true),
        ],
      ),
      child: Material(
        child: Ink(
          color: Colors.white,
          child: InkWell(
            hoverColor: Theme.of(context).primaryColor.withValues(alpha: .1),
            onDoubleTap: setTargetFolder,
            onSecondaryTap: openFolder,
            child: Row(
              children: [
                CheckTile(
                  check: file.checked,
                  label: fileName,
                  fontSize: AppNum.tileFontSize,
                  onChanged: (v) => toggleCheck(ref, file.id),
                  color: Colors.grey,
                ),
                // const SizedBox(width: AppNum.smallG),
                // Icon(
                //   getFileIcon(file.extension),
                //   color: Theme.of(context).primaryColor,
                //   size: AppNum.defaultIconS,
                // ),
                // NormalTile(label: fileName, fontSize: AppNum.tileFontSize),
                NormalTile(label: fileFolder, fontSize: AppNum.tileFontSize),
                // SizedBox(
                //   width: AppNum.deleteBtnS,
                //   child: Center(
                //     child: Text(
                //       file.extension == 'dir' ? '' : file.extension,
                //       style: const TextStyle(fontSize: AppNum.tileFontSize),
                //     ),
                //   ),
                // ),
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
