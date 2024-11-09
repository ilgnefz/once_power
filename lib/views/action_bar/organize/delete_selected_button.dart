import 'dart:io';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/storage.dart';
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
        if (saveLog) saveLogContent(folder.filePath);
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
        if (saveLog) saveLogContent(file.filePath);
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
          return UnconstrainedBox(
            child: Container(
              width: 360,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_rounded, color: Colors.blue, size: 20),
                      SizedBox(width: AppNum.smallG),
                      Text(
                        S.of(context).tipTitle,
                        style: TextStyle(fontSize: 16).useSystemChineseFont(),
                      ),
                    ],
                  ),
                  SizedBox(height: AppNum.largeG),
                  Text(
                    S.of(context).tipMessage,
                    style: TextStyle(fontSize: 16).useSystemChineseFont(),
                  ),
                  SizedBox(height: AppNum.largeG),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          StorageUtil.setBool(AppKeys.isKnow, true);
                          Navigator.pop(context, true);
                        },
                        child: Text(S.of(context).tipButton1),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(S.of(context).tipButton2),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
      if (!context.mounted) return;
      NotificationType type = errorList.isEmpty
          ? SuccessNotification(
              S.of(context).deleteSuccessful, S.of(context).successDeleteInfo)
          : ErrorNotification(S.of(context).deleteFailed,
              S.of(context).failureDeleteInfo, errorList);
      NotificationMessage.show(type);
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : deleteSelected,
      child: Text(S.of(context).deleteSelected),
    );
  }
}
