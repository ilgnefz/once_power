import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

import '../../../cores/list.dart';
import '../../../providers/file.dart';
import '../../../widgets/action_bar/easy_dialog.dart';

class DeleteSelectedBtn extends ConsumerWidget {
  const DeleteSelectedBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InfoDetail> errorList = [];
    bool saveLog = ref.watch(isSaveLogProvider);

    Future<void> deleteSelectedFolders(FileInfo folder) async {
      try {
        Directory(folder.filePath).deleteSync(recursive: true);
        removeOne(ref, folder.id);
        if (saveLog) await tempSaveDeleteLog(ref, folder.filePath);
      } catch (e) {
        errorList.add(InfoDetail(
          file: folder.filePath,
          message: '${S.current.deleteFailed}: $e',
        ));
      }
    }

    Future<void> deleteSelectedFiles(FileInfo file) async {
      try {
        File(file.filePath).deleteSync();
        removeOne(ref, file.id);
        if (saveLog) await tempSaveDeleteLog(ref, file.filePath);
      } catch (e) {
        errorList.add(InfoDetail(
          file: file.filePath,
          message: '${S.current.deleteFailed}: $e',
        ));
      }
    }

    Future<bool?> dialogTipInfo() async {
      return await showDialog(
        context: context,
        builder: (context) {
          return EasyDialog(
            icon: Icons.info_rounded,
            title: S.of(context).tipTitle,
            content: S.of(context).deleteTipMessage,
            okText: S.of(context).deleteTipButton1,
            cancelText: S.of(context).deleteTipButton2,
            onOk: () {
              StorageUtil.setBool(AppKeys.isKnow, true);
              Navigator.pop(context, true);
            },
            onCancel: () => Navigator.pop(context, true),
          );
        },
      );
    }

    void deleteSelected() async {
      bool isKnow = StorageUtil.getBool(AppKeys.isKnow);
      if (!isKnow) {
        bool? result = await dialogTipInfo();
        if (result == null) return;
      }
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (!file.checked) continue;
        bool isFile = await FileSystemEntity.isFile(file.filePath);
        if (isFile) deleteSelectedFiles(file);
        if (!isFile) deleteSelectedFolders(file);
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
