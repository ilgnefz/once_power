import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

class ApplyRenameBtn extends ConsumerWidget {
  const ApplyRenameBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> allList = ref.watch(sortListProvider);
    List<FileInfo> list = allList.where((e) => e.checked).toList();

    void apply() async {
      await runRename(ref, (
        WidgetRef ref,
        List<FileInfo> list,
        FileInfo file,
      ) async {
        // 获取带有扩展名的新文件名
        String oldPath = file.tempPath == '' ? file.filePath : file.tempPath;
        String newPath = getNewPath(file);
        if (file.filePath == newPath) return null;
        // 检测文件是否存在，存在会返回一个 InfoDetail 对象
        InfoDetail? info = await checkFile(ref, list, file);
        // 存在就不会继续执行后续代码
        if (info != null) return info;
        info = await rename(ref, file, oldPath, newPath);
        return info;
      }, (List<InfoDetail> errors, int total) async {
        showRenameNotification(errors, total);
        if (ref.watch(isSaveLogProvider)) {
          await removeLogCache(S.of(context).renameLogs);
        }
      });
      updateName(ref);
      if (ref.watch(isModifyExtensionProvider)) {
        ref.read(isModifyExtensionProvider.notifier).update();
        ref.read(extensionControllerProvider.notifier).clear();
      }
      ref.read(openUndoProvider.notifier).update(true);
    }

    return EasyElevatedBtn(
      onPressed: list.isNotEmpty ? apply : null,
      label: S.of(context).applyChange,
    );
  }
}
