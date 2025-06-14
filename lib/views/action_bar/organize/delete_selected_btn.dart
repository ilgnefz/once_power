import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

class DeleteSelectedBtn extends ConsumerWidget {
  const DeleteSelectedBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InfoDetail> errorList = [];
    bool saveLog = ref.watch(isSaveLogProvider);

    void deleteSelected() async {
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (!file.checked) continue;
        final result = deleteToTrash(filePath: file.filePath);
        if (result == null) {
          removeOne(ref, file.id);
          if (saveLog) await tempSaveDeleteLog(ref, file.filePath);
        } else {
          errorList.add(InfoDetail(
            file: file.filePath,
            message: '${S.current.deleteFailed}: $result',
          ));
        }
      }
      showDeleteNotification(errorList);
      if (ref.watch(isSaveLogProvider)) {
        await removeLogCache(S.current.deleteLog);
      }
    }

    return EasyElevatedBtn(
      onPressed: disabledBtn(ref) ? null : deleteSelected,
      label: S.of(context).deleteChecked,
    );
  }
}
