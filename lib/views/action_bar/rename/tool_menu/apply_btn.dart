import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/notification.dart';
import 'package:path/path.dart' as path;

class ApplyBtn extends ConsumerWidget {
  const ApplyBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> fileList = ref.watch(sortListProvider);
    List<FileInfo> checkList = fileList.where((e) => e.checked).toList();
    List<NotificationInfo> errorList = [];
    int total = checkList.length;

    void applyRename() async {
      if (total > 1) {
        FileInfo first = checkList.first;
        FileInfo f = checkList.firstWhere((f) {
          return f.filePath == first.filePath;
        }, orElse: () => nullFile);
        if (f == nullFile) checkList = checkList.reversed.toList();
        await rename(ref, checkList, errorList);
      } else {
        await rename(ref, checkList, errorList);
      }
      bool isViewMode = ref.watch(viewModeProvider);
      if (isViewMode) ref.read(refreshImageProvider.notifier).update();
      updateName(ref);
      updateExtension(ref);
      NotificationType type = errorList.isNotEmpty
          ? ErrorNotification(S.current.failed,
              S.current.failedNum(errorList.length, total), errorList)
          : SuccessNotification(
              S.current.successful, S.current.successfulNum(total));
      NotificationMessage.show(type);
    }

    return ElevatedButton(
      onPressed: fileList.isEmpty ? null : applyRename,
      child: Text(S.of(context).applyChange),
    );
  }
}

Future<void> rename(WidgetRef ref, List<FileInfo> list,
    List<NotificationInfo> errorList) async {
  ref.read(totalProvider.notifier).update(list.length);
  int count = 0;
  bool delay = list.length > AppNum.maxFileNum;
  int startTime = DateTime.now().microsecondsSinceEpoch;
  for (FileInfo f in list) {
    count++;
    String oldPath = f.filePath;
    String newName = getFileName(f.newName, f.newExtension);
    String newPath = path.join(f.parent, newName);
    if (oldPath == newPath) continue;
    NotificationInfo? info = await renameFile(ref, (f.id, oldPath, newPath));
    if (info != null) errorList.add(info);
    if (delay) await Future.delayed(const Duration(microseconds: 1));
  }
  ref.read(countProvider.notifier).update(count);
  renameTemp(ref);
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
}
