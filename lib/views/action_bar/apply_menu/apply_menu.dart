import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/file.dart';
import 'package:once_power/views/action_bar/apply_menu/apply_button.dart';
import 'package:once_power/widgets/click_text.dart';

class ApplyMenu extends ConsumerWidget {
  const ApplyMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String selectFile = '选择文件';
    const String selectFolder = '选择文件夹';

    void addFile() async {
      final List<XFile> files = await openFiles();
      if (files.isNotEmpty) xFileFormat(ref, files);
    }

    void addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) {
        bool append = ref.watch(appendModeProvider);
        if (!append) ref.read(fileListProvider.notifier).clear();
        // bool addFolder = ref.watch(addFolderProvider);
        // if (addFolder) ref.read(totalProvider.notifier).update(folders.length);
        for (var folder in folders) {
          fileFormat(ref, folder!);
        }
      }
    }

    return Row(
      children: [
        ClickText(selectFile, onTap: addFile),
        ClickText(selectFolder, onTap: addFolder),
        const Spacer(),
        const ApplyButton(),
      ],
    );
  }
}
