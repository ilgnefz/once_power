import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/easy_scroll_bar.dart';

import 'empty.dart';
import 'organize/organize_file_tile.dart';
import 'organize/organize_title_bar.dart';
import 'rename/rename_file_tile.dart';
import 'rename/rename_title_bar.dart';
import 'rename/view_model/view_grid_view.dart';
import 'rename/view_model/view_model_title_bar.dart';

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
    bool isOrganize = ref.watch(currentModeProvider).isOrganize;
    bool isViewMode = ref.watch(viewModeProvider);

    Future<void> dropAdd(DropDoneDetails details) async {
      List<XFile> paths = details.files;
      if (paths.isNotEmpty) {
        List<String> pathsList = paths.map((e) => e.path).toList();
        await formatPath(ref, pathsList);
      }
    }

    Widget buildTitleBar() {
      if (isOrganize) return const OrganizeTitleBar();
      if (isViewMode) return const ViewModeTitleBar();
      return const RenameTitleBar();
    }

    return Expanded(
      child: Column(
        children: [
          SizedBox(height: AppNum.fileCardH, child: buildTitleBar()),
          Expanded(
            child: DropTarget(
              onDragDone: dropAdd,
              child: ContentListView(
                isViewMode: isViewMode,
                isOrganize: isOrganize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentListView extends ConsumerWidget {
  const ContentListView({
    super.key,
    required this.isViewMode,
    required this.isOrganize,
  });

  final bool isViewMode;
  final bool isOrganize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> files = ref.watch(sortListProvider);
    if (files.isEmpty) return const EmptyView();
    if (isViewMode && !isOrganize) return const ViewGridView();

    ScrollController controller = ref.watch(scrollBarControllerProvider);

    void reorderList(int oldIndex, int newIndex) {
      if (newIndex > oldIndex) newIndex -= 1;
      FileInfo item = files.removeAt(oldIndex);
      files.insert(newIndex, item);
      FunctionMode mode = ref.watch(currentModeProvider);
      ref.read(fileListProvider.notifier).addAll(files);
      ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
      if (mode == FunctionMode.organize) {
        TextEditingController controller = ref.watch(targetControllerProvider);
        bool isFile = files.first.extension != 'dir';
        if (controller.text.isEmpty) {
          controller.text = isFile ? files.first.parent : files.first.filePath;
        }
      }
      updateName(ref);
      updateExtension(ref);
    }

    return EasyScrollbar(
      controller: controller,
      child: ReorderableListView.builder(
        scrollController: controller,
        itemCount: files.length,
        padding: const EdgeInsets.only(right: AppNum.defaultP),
        buildDefaultDragHandles: false,
        onReorder: reorderList,
        itemBuilder: (BuildContext context, int index) {
          return ReorderableDragStartListener(
            index: index,
            key: ValueKey(files[index].id),
            child: isOrganize
                ? OrganizeFileTile(files[index])
                : RenameFileTile(file: files[index], files: files),
          );
        },
      ),
    );
  }
}
