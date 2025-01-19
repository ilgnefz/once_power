import 'dart:io';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/easy_dialog.dart';
import 'package:once_power/widgets/common/notification.dart';

class DeleteSelectedButton extends ConsumerWidget {
  const DeleteSelectedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationInfo> errorList = [];
    bool saveLog = ref.watch(saveLogProvider);

    void deleteSelectedFolders(FileInfo folder) {
      try {
        Directory(folder.filePath).deleteSync(recursive: true);
        deleteOne(ref, folder.id);
        if (saveLog) tempSaveDeleteLog(ref, folder.filePath);
      } catch (e) {
        errorList.add(NotificationInfo(
          file: folder.filePath,
          message: '${S.of(context).deleteFailed}: $e',
        ));
      }
    }

    void deleteSelectedFiles(FileInfo file) {
      try {
        File(file.filePath).deleteSync();
        deleteOne(ref, file.id);
        if (saveLog) tempSaveDeleteLog(ref, file.filePath);
      } catch (e) {
        errorList.add(NotificationInfo(
          file: file.filePath,
          message: '${S.of(context).deleteFailed}: $e',
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
      bool isKnow = StorageUtil.getBool(AppKeys.isKnow) ?? false;
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
      if (ref.watch(saveLogProvider)) {
        List<String> logs = ref.watch(operateLogListProvider);
        await createLog('', S.current.deleteLog, logs);
        ref.read(operateLogListProvider.notifier).clear();
      }
      NotificationType type = errorList.isEmpty
          ? SuccessNotification(
              S.current.deleteSuccessful, S.current.successDeleteInfo)
          : ErrorNotification(
              S.current.deleteFailed, S.current.failureDeleteInfo, errorList);
      NotificationMessage.show(type);
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : deleteSelected,
      child: Text(S.of(context).deleteChecked, style: TextStyle(fontSize: 14)),
    );
  }
}
