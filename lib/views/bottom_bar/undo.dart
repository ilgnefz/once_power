import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/bottom_bar/text_btn.dart';

class UndoBtn extends ConsumerWidget {
  const UndoBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> undoRename() async {
      ref.read(openUndoProvider.notifier).update(true);
      await runRename(ref, (
        WidgetRef ref,
        List<FileInfo> list,
        FileInfo file,
      ) async {
        String oldPath = file.tempPath == '' ? file.filePath : file.tempPath;
        String newPath = file.beforePath;
        if (file.filePath == newPath) return null;
        InfoDetail? info = await checkFile(ref, list, file, true);
        if (info != null) return info;
        info = await rename(ref, file, oldPath, newPath);
        return info;
      }, (List<InfoDetail> errors, int total) async {
        showUndoNotification(errors, total);
      });
      ref.read(openUndoProvider.notifier).update(false);
    }

    if (!ref.watch(openUndoProvider) ||
        ref.watch(currentModeProvider).isOrganize) {
      return SizedBox.shrink();
    }

    return TextBtn(
      text: S.of(context).undo,
      onTap: undoRename,
    );
  }
}
