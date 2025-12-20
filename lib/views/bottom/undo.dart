import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/text_btn.dart';

class UndoBtn extends ConsumerWidget {
  const UndoBtn({super.key});

  Future<void> undoRename(WidgetRef ref) async {
    ref.read(showUndoProvider.notifier).update(true);
    bool complete = await runRename(
      ref,
      (WidgetRef ref, List<FileInfo> list, FileInfo file) async {
        String oldPath = file.tempPath == '' ? file.path : file.tempPath;
        String newPath = file.beforePath;
        if (file.path == newPath) return null;
        InfoDetail? info = await checkFile(ref, list, file, true);
        if (info != null && !StorageUtil.getBool(AppKeys.autoRename)) {
          return info;
        }
        info = await rename(ref, file, oldPath, newPath);
        return info;
      },
      (List<InfoDetail> errors, int total) async {
        showUndoNotification(errors, total);
      },
    );
    if (!complete) return;
    ref.read(showUndoProvider.notifier).update(false);
    updateName(ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(showUndoProvider) ||
        ref.watch(currentModeProvider).isOrganize) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(left: AppNum.spaceSmall),
      child: TextBtn(tr(AppL10n.bottomUndo), onPressed: () => undoRename(ref)),
    );
  }
}
