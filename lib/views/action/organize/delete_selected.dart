import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/widgets/base/easy_elevated_btn.dart';

class DeleteSelectedBtn extends ConsumerWidget {
  const DeleteSelectedBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InfoDetail> errorList = [];
    bool saveLog = ref.watch(isSaveLogProvider);

    void deleteSelected() async {
      List<String> deletePaths = [];
      List<FileInfo> files = ref.read(fileListProvider);
      for (FileInfo file in files) {
        if (!file.checked) continue;
        removeOne(ref, file);
        deletePaths.add(file.path);
        if (saveLog) await tempSaveDeleteLog(ref, file.path);
        // try {
        //   await deleteToTrash(filePath: file.filePath);
        //   removeOne(ref, file.id);
        //   if (saveLog) await tempSaveDeleteLog(ref, file.filePath);
        // } catch (e) {
        //   errorList.add(InfoDetail(
        //     file: file.filePath,
        //     message: '${S.current.deleteFailed}: $e',
        //   ));
        // }
      }
      try {
        await deleteAllToTrash(filePaths: deletePaths);
      } catch (e) {
        errorList.add(
          InfoDetail(
            file: tr(AppL10n.errDelete),
            message: '${tr(AppL10n.errDelete)}: $e',
          ),
        );
      }
      showDeleteNotification(errorList, false);
      if (ref.watch(isSaveLogProvider)) {
        await removeLogCache(tr(AppL10n.logDelete));
      }
    }

    return EasyElevatedBtn(
      label: tr(AppL10n.organizeSelected),
      // onPressed: disabledBtn(ref) ? null : deleteSelected,
      onPressed: deleteSelected,
    );
  }
}
