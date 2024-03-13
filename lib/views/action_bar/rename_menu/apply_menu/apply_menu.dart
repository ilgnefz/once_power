import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/file.dart';
import 'package:once_power/widgets/custom_text_button.dart';

import 'apply_button.dart';

class ApplyMenu extends ConsumerWidget {
  const ApplyMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addFile() async {
      final List<XFile> files = await openFiles();
      if (files.isNotEmpty) formatXFile(ref, files);
    }

    void addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isNotEmpty) {
        bool append = ref.watch(appendModeProvider);
        if (!append) ref.read(fileListProvider.notifier).clear();
        for (var folder in folders) {
          formatFile(ref, folder!);
        }
      }
    }

    return Row(
      children: [
        CustomTextButton(S.of(context).addFile, onTap: addFile),
        const SizedBox(width: 4),
        CustomTextButton(S.of(context).selectFolder, onTap: addFolder),
        const Spacer(),
        const ApplyButton(),
      ],
    );
  }
}
