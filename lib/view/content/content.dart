import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/core/upload.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/view/content/empty.dart';

import 'grid/grid.dart';
import 'list/list.dart';
import 'top/top.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RepaintBoundary(child: ContentTop()),
        Expanded(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return DropTarget(
                child: Builder(
                  builder: (BuildContext context) {
                    List<FileInfo> files = ref.watch(fileListProvider);
                    if (files.isEmpty) return EmptyView();
                    if (ref.watch(isViewModeProvider)) return ContentGridView();
                    return ContentListView();
                  },
                ),
                onDrop: (DropDetails details) => dropFiles(details, ref),
              );
            },
          ),
        ),
      ],
    );
  }
}
