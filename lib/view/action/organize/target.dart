import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/widget/action/folder_input.dart';

class TargetInput extends ConsumerWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: AppNum.padding),
      child: FolderInput(
        cacheKey: AppKeys.targetFolder,
        cacheListKey: AppKeys.targetFolderList,
        controller: ref.watch(folderControllerProvider),
        onUpload: (value) =>
            ref.read(folderControllerProvider.notifier).update(value),
      ),
    );
  }
}
