import 'package:image_size_getter/image_size_getter.dart';

import 'file_enum.dart';

class FileInfo {
  String id;

  /// a
  String name;
  String phonetic;
  String newName;

  /// C:\Photos
  String parent;

  /// C:\Photos\a.jpg
  String filePath;
  String tempPath;

  /// jpg
  String extension;
  String newExtension;

  /// C:\Photos\a.jpg
  String beforePath;
  DateTime createdDate;
  DateTime modifiedDate;
  DateTime? exifDate;
  FileClassify type;
  int size;
  Size? dimensions;
  bool checked;

  FileInfo({
    required this.id,
    required this.name,
    required this.phonetic,
    required this.newName,
    required this.parent,
    required this.filePath,
    required this.tempPath,
    required this.extension,
    required this.newExtension,
    required this.beforePath,
    required this.createdDate,
    required this.modifiedDate,
    this.exifDate,
    required this.type,
    required this.size,
    required this.dimensions,
    required this.checked,
  });

  @override
  String toString() {
    return 'FileInfo{'
        'id: $id, '
        'name: $name, '
        'phonetic: $phonetic, '
        'newName: $newName, '
        'parent: $parent, '
        'filePath: $filePath, '
        'tempPath: $tempPath, '
        'extension: $extension, '
        'newExtension: $newExtension, '
        'beforePath: $beforePath, '
        'createdDate: $createdDate, '
        'modifiedDate: $modifiedDate, '
        'exifDate: $exifDate, '
        'type: $type, '
        'size: $size, '
        'dimensions: $dimensions, '
        'checked: $checked}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phonetic': phonetic,
      'newName': newName,
      'parent': parent,
      'filePath': filePath,
      'tempPath': tempPath,
      'extension': extension,
      'newExtension': newExtension,
      'beforePath': beforePath,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'modifiedDate': modifiedDate.millisecondsSinceEpoch,
      'exifDate': exifDate?.millisecondsSinceEpoch,
      'type': type.index,
      'size': size,
      'dimensions': dimensions,
      'checked': checked,
    };
  }
}

class CsvRenameInfo {
  String nameA;
  String nameB;

  CsvRenameInfo({
    required this.nameA,
    required this.nameB,
  });

  @override
  String toString() {
    return 'CsvRenameInfo(nameA: $nameA, nameB: $nameB)';
  }
}

class UploadMarkInfo {
  String name;
  String content;
  bool isPrefix;

  UploadMarkInfo({
    required this.name,
    required this.content,
    this.isPrefix = true,
  });

  @override
  String toString() {
    return 'UploadMarkInfo{name: $name, content: $content, isPrefix: $isPrefix}';
  }
}
