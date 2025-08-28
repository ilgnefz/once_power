import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart' show AppKeys;
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/progress.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/views/content_bar/hide_content.dart';

import 'content_top_bar.dart';
import 'empty_content.dart';
import 'grid_view/content_grid.dart';
import 'list_view/content_list.dart';
import 'progress_view.dart';

class ContentBar extends ConsumerStatefulWidget {
  const ContentBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentBarState();
}

class _ContentBarState extends ConsumerState<ContentBar> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () async {
    //   await AppHotKey.init(ref);
    // });
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
        color: Colors.transparent,
        // color: ref.watch(currentThemeModeProvider) == ThemeMode.light
        //     ? Colors.white
        //     : Color(0xFF121212),
        child: Builder(
          builder: (context) {
            ProgressFileInfo? info = ref.watch(currentProgressFileProvider);
            bool than = getAllSize(ref) > AppNum.maxFileSize;
            if (info != null && than) return ProgressView(info: info);
            return Column(
              children: [
                ContentTopBar(),
                Expanded(
                  child: DropTarget(
                    onDragDone: (details) async {
                      List<XFile> paths = details.files;
                      if (paths.isNotEmpty) {
                        final files = paths.map((e) => e.path).toList();
                        await formatPath(ref, files);
                      }
                    },
                    child: Builder(
                      builder: (_) {
                        bool isOrganize = ref
                            .watch(currentModeProvider)
                            .isOrganize;
                        bool showChange = ref.watch(showChangeProvider);
                        List<FileInfo> files = ref.watch(sortListProvider);
                        if (files.isNotEmpty && showChange && !isOrganize) {
                          files = files
                              .where(
                                (e) =>
                                    e.name != e.newName ||
                                    e.extension != e.newExtension,
                              )
                              .toList();
                          if (files.isEmpty) return HideContent();
                        }
                        if (files.isEmpty) return EmptyContent();
                        if (isViewNoOrganize(ref)) {
                          return ContentGrid(files: files);
                        }
                        return ContentList(files: files);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
