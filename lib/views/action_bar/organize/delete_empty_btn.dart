import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

import '../../../cores/notification.dart';
import '../../../cores/oplog.dart';
import '../../../models/extension.dart' as FileClassify;
import '../../../providers/file.dart';
import '../../../providers/list.dart';

class DeleteEmptyBtn extends ConsumerWidget {
  const DeleteEmptyBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InfoDetail> errorList = [];
    bool saveLog = ref.watch(isSaveLogProvider);

    Future<void> delete(Directory directory) async{
      try {
        directory.deleteSync();
        // if (saveLog) saveLogContent(directory.path);
        if (saveLog) await tempSaveDeleteLog(ref, directory.path);
      } catch (e) {
        errorList.add(InfoDetail(
          file: directory.path,
          message: '${S.of(context).deleteFailed}: $e',
        ));
      }
    }

    Future<void> deleteFolders(String folderPath) async{
      var directory = Directory(folderPath);
      if (directory.existsSync()) {
        bool isEmpty = directory.listSync().isEmpty;
        if (isEmpty) return await delete(directory);
        directory.listSync().forEach((file) {
          if (FileSystemEntity.isDirectorySync(file.path)) {
            deleteFolders(file.path);
          }
        });
        if (directory.listSync().isEmpty) delete(directory);
      }
    }

    Future<void> deleteEmptyFolder() async {
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (!file.checked) continue;
        if (!file.type.isFolder) continue;
        deleteFolders(file.filePath);
      }
      showDeleteNotification(errorList);
      if (ref.watch(isSaveLogProvider)) await removeLogCache(S.current.deleteLog);
    }

    return EasyElevatedBtn(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : deleteEmptyFolder,
      label: S.of(context).deleteEmptyFolder,
    );
  }
}
