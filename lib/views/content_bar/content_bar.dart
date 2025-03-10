import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart' show AppKeys;
import 'package:once_power/cores/file.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/verify.dart';

import 'content_top_bar.dart';
import 'empty_content.dart';
import 'grid_view/content_grid.dart';
import 'list_view/content_list.dart';

class ContentBar extends ConsumerStatefulWidget {
  const ContentBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentBarState();
}

class _ContentBarState extends ConsumerState<ContentBar> {
  @override
  void initState() {
    super.initState();
    List<String> fPath = StorageUtil.getStringList(AppKeys.rightMenuFolderPath);
    if (fPath.isNotEmpty) {
      Future.delayed(Duration.zero, () async {
        await formatPath(ref, fPath);
      });
      StorageUtil.remove(AppKeys.rightMenuFolderPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            ContentTopBar(),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return DropTarget(
                    onDragDone: (details) async {
                      List<XFile> paths = details.files;
                      if (paths.isNotEmpty) {
                        await formatPath(
                            ref, paths.map((e) => e.path).toList());
                      }
                    },
                    child: child!,
                  );
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    List<FileInfo> files = ref.watch(sortListProvider);
                    if (files.isEmpty) return EmptyContent();
                    if (isViewNoOrganize(ref)) return ContentGrid(files: files);
                    return ContentList(files: files);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
