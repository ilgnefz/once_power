import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/upload.dart';
import 'package:once_power/model/progress.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/view/content/content_center.dart';
import 'package:once_power/view/content/progress.dart';
import 'package:once_power/view/content/top/top.dart';

class ContentView extends ConsumerWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(sortSelectListProvider.notifier).clear();
          ref.read(conetentFocusNodeProvider).requestFocus();
        },
        child: Builder(
          builder: (context) {
            ProgressFileInfo? progress = ref.watch(currentProgressFileProvider);
            if (progress != null && getTotalSize(ref) > AppNum.maxSize) {
              return ProgressView(info: progress);
            }
            return Column(
              children: [
                ContentTop(),
                DropTarget(
                  onDragDone: (details) => dropFile(details, ref),
                  child: Expanded(child: ContentCenter()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
