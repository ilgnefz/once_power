import 'dart:io';

import 'package:once_power/model/enum.dart';
import 'package:once_power/utils/notification.dart';

void deleteFolders(String folderPath) {
  var directory = Directory(folderPath);
  if (directory.existsSync()) {
    var isEmpty = directory.listSync().isEmpty;
    if (isEmpty) {
      directory.deleteSync();
    } else {
      directory.listSync().forEach((file) {
        if (FileSystemEntity.isDirectorySync(file.path)) {
          deleteFolders(file.path);
        }
      });
      if (directory.listSync().isEmpty) {
        try {
          directory.deleteSync();
        } catch (e) {
          NotificationMessage.show(
            '删除失败',
            '删除失败，$e',
            [],
            MessageType.failure,
          );
        }
      }
    }
  }
}
