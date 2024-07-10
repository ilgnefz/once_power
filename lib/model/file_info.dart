import 'package:once_power/model/enum.dart';

class FileInfo {
  String id;
  String name;
  String newName;
  String parent;
  String filePath;
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
    required this.newName,
    required this.parent,
    required this.filePath,
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
    return 'FileInfo(id: $id, name: $name, newName: $newName, parent: $parent,filePath: $filePath, extension: $extension, newExtension: $newExtension, beforePath: $beforePath, createdDate: $createdDate, modifiedDate: $modifiedDate, exifDate: $exifDate, type: $type, checked: $checked)';
  }
}

class EasyRenameInfo {
  String nameA;
  String nameB;

  EasyRenameInfo({
    required this.nameA,
    required this.nameB,
  });

  @override
  String toString() {
    return 'EasyRenameInfo(nameA: $nameA, nameB: $nameB)';
  }
}
