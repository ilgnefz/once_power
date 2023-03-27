import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/utils/notification.dart';
import 'package:path/path.dart' as path;

class OrganizeFileProvider extends ChangeNotifier {
  final List<FileInfo> _showFileList = [];
  List<FileInfo> get showFileList => _showFileList;
  final List<FileInfo> _realFileList = [];

  void dropFile(DropDoneDetails detail) {
    final List<XFile> files = detail.files;
    for (XFile file in files) {
      String name = file.name;
      String filePath = file.path;
      String extension = 'dir';
      if (name.contains('.')) {
        extension = path.extension(filePath).replaceFirst('.', '');
      }
      IconData icon = getFileIcon(extension);
      addFileInfo(name, filePath, icon);
    }
  }

  IconData getFileIcon(String extension) {
    if (folder.contains(extension)) return Icons.folder_rounded;
    if (image.contains(extension)) return Icons.image_rounded;
    if (video.contains(extension)) return Icons.video_file_rounded;
    if (text.contains(extension)) return Icons.text_snippet_rounded;
    if (audio.contains(extension)) return Icons.audio_file_rounded;
    return Icons.data_saver_off_outlined;
  }

  void addFileInfo(String name, String filePath, IconData icon) {
    String id = nanoid(10);
    FileInfo fileInfo =
        FileInfo(id: id, name: name, filePath: filePath, icon: icon);
    if (!_showFileList.any((e) => e.filePath == fileInfo.filePath)) {
      _showFileList.add(fileInfo);
      notifyListeners();
    }
  }

  String _targetFolder = '';
  String get targetFolder => _targetFolder;
  void addFolder([bool targetFolder = false]) async {
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) {
      if (targetFolder) {
        _targetFolder = dir;
      } else {
        String name = dir.split(Platform.pathSeparator).last;
        String filePath = path.dirname(name);
        addFileInfo(name, filePath, Icons.folder_rounded);
      }
    }
  }

  void clearTargetFolder() {
    _targetFolder = '';
    notifyListeners();
  }

  void clearFiles(String id) {
    _showFileList.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void clearAllFiles() {
    _showFileList.clear();
    notifyListeners();
  }

  void deleteEmptyFolder() {
    if (_showFileList.isNotEmpty) {
      for (FileInfo file in _showFileList) {
        if (file.icon == Icons.folder_rounded) deleteFolders(file.filePath);
      }
    }
  }

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
          directory.deleteSync();
        }
      }
    }
  }

  void startOrganize() {
    if (_showFileList.isNotEmpty) {
      for (FileInfo file in _showFileList) {
        if (file.icon == Icons.folder_rounded) {
          getAllFile(file.filePath);
        } else {
          _realFileList.add(file);
        }
      }
      organizeFile();
    }
  }

  void getAllFile(dir) {
    Directory directory = Directory(dir);
    List<FileSystemEntity> files = directory.listSync(recursive: true);
    if (files.isNotEmpty) {
      for (FileSystemEntity file in files) {
        String id = nanoid(10);
        _realFileList.add(
          FileInfo(
            id: id,
            name: path.basename(file.path),
            filePath: file.path,
            icon: getFileIcon(path.extension(file.path)),
          ),
        );
      }
    }
  }

  void verifyFile(String filePath, String newPath, [int index = 0]) {
    if (File(newPath).existsSync()) {
      int extensionIndex = newPath.lastIndexOf('.');
      String mark = nanoid(10).substring(4);
      newPath =
          '${newPath.substring(0, extensionIndex)} $mark${newPath.substring(extensionIndex)}';
      verifyFile(filePath, newPath);
    } else {
      File(filePath).renameSync(newPath);
    }
  }

  void organizeFile() {
    for (FileInfo file in _realFileList) {
      List<String> pathList = file.filePath.split(Platform.pathSeparator);
      String destDir = _targetFolder == ''
          ? [pathList.first, pathList[1]].join(Platform.pathSeparator)
          : _targetFolder;
      try {
        String newPath = path.join(destDir, path.basename(file.filePath));
        if (file.filePath == newPath) continue;
        verifyFile(file.filePath, newPath);
        notifyListeners();
        NotificationMessage.show(S.current.organizeSuccess,
            '${S.current.organizeSuccess} 🎉', MessageType.success);
      } catch (e) {
        NotificationMessage.show(
            S.current.organizeFailed, '$e', MessageType.failure);
      }
    }
  }
}
