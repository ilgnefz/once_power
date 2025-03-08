import 'file_enum.dart';

class FileInfo {
  String id;
  String name;
  String phonetic;
  String newName;
  String parent;
  String filePath;
  String tempPath;
  String extension;
  String newExtension;
  String beforePath;
  DateTime createdDate;
  DateTime modifiedDate;
  DateTime? exifDate;
  FileClassify type;
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
    required this.checked,
  });

  @override
  String toString() {
    return 'FileInfo{id: $id, name: $name, phonetic: $phonetic, newName: $newName, parent: $parent, filePath: $filePath, tempPath: $tempPath, extension: $extension, newExtension: $newExtension, beforePath: $beforePath, createdDate: $createdDate, modifiedDate: $modifiedDate, exifDate: $exifDate, type: $type, checked: $checked}';
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

// class TempFileInfo {
//   final FileInfo file;
//   final String tempPath;
//   final String oldPath;
//   final String newPath;
//
//   TempFileInfo({
//     required this.file,
//     required this.tempPath,
//     required this.oldPath,
//     required this.newPath,
//   });
//
//   @override
//   String toString() {
//     return 'TempFileInfo{file: $file, tempPath: $tempPath, oldPath: $oldPath, newPath: $newPath}';
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'file': file.toJson(),
//       'tempPath': tempPath,
//       'oldPath': oldPath,
//       'newPath': newPath,
//     };
//   }
// }
