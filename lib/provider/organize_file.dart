import 'dart:async';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/notification.dart';
import 'package:path/path.dart' as path;

class OrganizeFileProvider extends ChangeNotifier {
  int _total = 0;
  int get total => _total;
  int _count = 0;
  int get count => _count;

  bool _saveLog = false;
  bool get saveLog => _saveLog;
  toggleCheck() {
    _saveLog = !_saveLog;
    notifyListeners();
  }

  String _loadingMessage = S.current.adding;
  String get loadingMessage => _loadingMessage;

  final StreamController<String> _addStream = StreamController<String>();
  StreamSubscription<String>? _addSubscription;
  final StreamController<FileInfo> _organizeStream =
      StreamController<FileInfo>();
  StreamSubscription<FileInfo>? _organizeSubscription;

  TextEditingController targetController = TextEditingController();

  final List<FileInfo> _showList = [];
  List<FileInfo> get showList => _showList;
  final List<FileInfo> _realList = [];
  List<FileInfo> get realList => _realList;

  OrganizeFileProvider() {
    _addSubscription = _addStream.stream.listen((String filePath) {
      FileSystemEntity file = File(filePath);
      String name = path.basename(filePath);
      bool isFile = file.statSync().type == FileSystemEntityType.file;
      String extension =
          isFile ? path.extension(file.path).substring(1) : 'dir';
      if (filter.contains(extension)) return;
      if (extension == 'dir') targetController.text = filePath;
      addList(name, filePath, extension);
    });
    _organizeSubscription = _organizeStream.stream.listen((FileInfo fileInfo) {
      String newPath =
          path.join(targetController.text, path.basename(fileInfo.filePath));
      if (newPath != fileInfo.filePath) {
        if (File(newPath).existsSync()) newPath = renameFile(newPath);
        if (saveLog) {
          final fileName = formatDateTime(DateTime.now()).substring(0, 14);
          final log = File(path.join(targetController.text, '$fileName.log'));
          String contents = '${fileInfo.filePath} ===> $newPath';
          log.writeAsStringSync('$contents\n', mode: FileMode.append);
        }
        File(fileInfo.filePath).renameSync(newPath);
      }
    });
  }

  String renameFile(String newPath) {
    int index = newPath.lastIndexOf('.');
    if (index == -1) index = newPath.length;
    int num = 0;
    while (
        File('${newPath.substring(0, index)} - $num${newPath.substring(index)}')
            .existsSync()) {
      num++;
    }
    return '${newPath.substring(0, index)} - $num${newPath.substring(index)}';
  }

  @override
  void dispose() {
    _addSubscription?.cancel();
    _organizeSubscription?.cancel();
    targetController.dispose();
    super.dispose();
  }

  void dropFile(DropDoneDetails detail) {
    _loadingMessage = S.current.adding;
    List<XFile> files = detail.files;
    _total = files.length;
    if (_addSubscription!.isPaused) _addSubscription!.resume();
    for (XFile xFile in files) {
      _count++;
      _addStream.add(xFile.path);
    }
    _total = 0;
    _count = 0;
    notifyListeners();
  }

  void addFolder() async {
    _loadingMessage = S.current.adding;
    String? folder = await FilePicker.platform.getDirectoryPath();
    if (folder != null) {
      if (_addSubscription!.isPaused) _addSubscription!.resume();
      _addStream.add(folder);
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

  void addList(String name, String filePath, String extension) {
    if (!_showList.any((e) => e.name == name && e.filePath == filePath)) {
      String id = nanoid(10);
      IconData icon = getFileIcon(extension);
      _showList
          .add(FileInfo(id: id, name: name, filePath: filePath, icon: icon));
      notifyListeners();
    }
  }

  void cancelAdd() {
    if (!_addSubscription!.isPaused) _addSubscription!.pause();
    if (!_organizeSubscription!.isPaused) _organizeSubscription!.pause();
    _total = 0;
    _count = 0;
    notifyListeners();
  }

  void clearList([String? id]) {
    if (id == null) {
      _showList.clear();
      targetController.clear();
    } else {
      bool isFolder =
          _showList.any((e) => e.id == id && e.icon == Icons.folder_rounded);
      if (isFolder) {
        String removeName = _showList.singleWhere((e) => e.id == id).filePath;
        if (removeName == targetController.text) targetController.clear();
      }
      _showList.removeWhere((e) => e.id == id);
    }
    notifyListeners();
  }

  void selectedTargetFolder() async {
    String? folder = await FilePicker.platform.getDirectoryPath();
    if (folder != null) {
      targetController.text = folder;
      notifyListeners();
    }
  }

  void deleteTargetFolder() {
    targetController.clear();
    notifyListeners();
  }

  void deleteEmptyFolder() {
    for (FileInfo file in _showList) {
      if (file.icon == Icons.folder_rounded) {
        deleteFolders(file.filePath);
        NotificationMessage.show(S.current.deleteSucceeded,
            S.current.deleteSucceededText, MessageType.success);
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
        if (directory.listSync().isEmpty) directory.deleteSync();
      }
    }
  }

  void getRealList() {
    for (FileInfo fileInfo in _showList) {
      if (fileInfo.icon == Icons.folder_rounded) {
        List<FileSystemEntity> files =
            Directory(fileInfo.filePath).listSync(recursive: true);
        for (FileSystemEntity f in files) {
          if (f.statSync().type == FileSystemEntityType.file) {
            String name = path.basename(f.path);
            String extension = path.extension(f.path).substring(1);
            if (filter.contains(extension)) continue;
            IconData icon = getFileIcon(extension);
            String id = nanoid(10);
            _realList.add(
                FileInfo(id: id, name: name, filePath: f.path, icon: icon));
          }
        }
      } else {
        _realList.add(fileInfo);
      }
    }
    notifyListeners();
  }

  void organizeFile() {
    _loadingMessage = S.current.processing;
    getRealList();
    _total = _realList.length;
    if (_organizeSubscription!.isPaused) _organizeSubscription!.resume();
    try {
      for (FileInfo fileInfo in _realList) {
        _count++;
        _organizeStream.add(fileInfo);
        notifyListeners();
      }
      NotificationMessage.show(S.current.organizeSuccess,
          S.current.organizeSuccess, MessageType.success);
    } catch (e) {
      NotificationMessage.show(
          S.current.organizeFailed, '$e', MessageType.failure);
    }
    _showList.clear();
    _realList.clear();
    _total = 0;
    _count = 0;
    notifyListeners();
  }
}
