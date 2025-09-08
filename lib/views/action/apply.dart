import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/widgets/base/easy_elevated_btn.dart';

class ApplyRename extends ConsumerWidget {
  const ApplyRename({super.key});

  void apply(BuildContext context, WidgetRef ref) async {
    bool complete = await runRename(
      ref,
      (WidgetRef ref, List<FileInfo> list, FileInfo file) async {
        // 获取带有扩展名的新文件名
        String oldPath = file.tempPath == '' ? file.path : file.tempPath;
        String newPath = getNewPath(file);
        if (file.path == newPath) return null;
        // 检测文件是否存在，存在会返回一个 InfoDetail 对象
        InfoDetail? info = await checkFile(ref, list, file);
        // 存在就不会继续执行后续代码
        if (info != null) return info;
        info = await rename(ref, file, oldPath, newPath);
        return info;
      },
      (List<InfoDetail> errors, int total) async {
        showRenameNotification(errors, total);
        if (ref.watch(isSaveLogProvider)) {
          await removeLogCache(tr(AppL10n.logRename));
        }
      },
    );
    if (!complete) return;
    updateName(ref);
    if (ref.watch(isModifyExtProvider)) {
      ref.read(isModifyExtProvider.notifier).update();
      ref.read(extensionControllerProvider.notifier).clear();
    }
    ref.read(showUndoProvider.notifier).update(true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedBtn(
      label: tr(AppL10n.renameApply),
      onPressed: () => apply(context, ref),
    );
  }
}
