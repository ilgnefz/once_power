import 'package:once_power/model/enum.dart';

class RenameFile {
  String id;
  String name;
  String newName;
  String parent;
  String filePath;
  String extension;
  DateTime createDate;
  DateTime modifyDate;
  DateTime? exifDate;
  FileClassify type;
  bool checked;

  RenameFile({
    required this.id,
    required this.name,
    required this.newName,
    required this.parent,
    required this.filePath,
    required this.extension,
    required this.createDate,
    required this.modifyDate,
    this.exifDate,
    required this.type,
    required this.checked,
  });

  @override
  String toString() {
    return 'RenameFile(id: $id, name: $name, newName: $newName, parent: $parent,filePath: $filePath, extension: $extension, createDate: $createDate, modifyDate: $modifyDate, exifDate: $exifDate, type: $type, checked: $checked)';
  }
}
