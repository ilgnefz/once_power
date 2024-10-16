import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/apply_btn.dart';
import 'package:once_power/widgets/common/easy_text_btn.dart';

class ApplyMenu extends ConsumerWidget {
  const ApplyMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> addFile() async {
      final List<XFile> files = await openFiles();
      if (files.isNotEmpty) await formatXFile(ref, files);
    }

    Future<void> addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) await formatFolder(ref, folders);
    }

    return Row(
      children: [
        EasyTextBtn(S.of(context).addFile, onTap: addFile),
        const SizedBox(width: AppNum.smallG),
        EasyTextBtn(S.of(context).selectFolder, onTap: addFolder),
        const Spacer(),
        const ApplyBtn(),
      ],
    );
  }
}
