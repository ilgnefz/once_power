import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/generated/l10n.dart';

import 'easy_btn.dart';

class AddFolderGroup extends ConsumerWidget {
  const AddFolderGroup({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> addFile() async {
      final List<XFile> files = await openFiles();
      if (files.isNotEmpty) await formatXFile(ref, files);
    }

    Future<void> addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) formatFolder(ref, folders);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppNum.mediumG,
        right: AppNum.defaultP,
        top: AppNum.smallG,
        bottom: AppNum.mediumG,
      ),
      child: Row(
        children: [
          EasyBtn(S.of(context).addFile, onTap: addFile),
          const SizedBox(width: AppNum.smallG),
          EasyBtn(S.of(context).selectFolder, onTap: addFolder),
          const Spacer(),
          child,
        ],
      ),
    );
  }
}
