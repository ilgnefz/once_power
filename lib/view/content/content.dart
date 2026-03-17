import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/upload.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/progress.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/view/content/empty.dart';
import 'package:once_power/view/content/grid/grid.dart';
import 'package:once_power/view/content/list/list.dart';
import 'package:once_power/view/content/progress.dart';
import 'package:once_power/view/content/top/top.dart';

final _viewProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(sortListProvider);
  bool isViewMode = ref.watch(isViewModeProvider);
  FunctionMode mode = ref.watch(currentModeProvider);

  bool showView = isViewMode && !mode.isOrganize;

  if (files.isEmpty) return EmptyView(showImage: showView);
  // if (ref.watch(onlyChangeProvider)) {
  //   files =
  //       files.where((e) => e.name != e.newName || e.ext != e.newExt).toList();
  // }
  if (showView) return ContentGridView(files);
  return ContentListView(files);
});

class ContentView extends ConsumerWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: () => ref.read(sortSelectListProvider.notifier).clear(),
        child: Builder(
          builder: (context) {
            ProgressFileInfo? progress = ref.watch(currentProgressFileProvider);
            if (progress != null && getTotalSize(ref) > AppNum.maxSize) {
              return ProgressView();
            }
            return Column(
              children: [
                ContentTop(),
                DropTarget(
                  onDragDone: (details) => dropFile(details, ref),
                  child: Expanded(child: ref.watch(_viewProvider)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
