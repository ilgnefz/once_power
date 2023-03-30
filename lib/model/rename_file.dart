import 'package:once_power/generated/l10n.dart';

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

enum FileClassify { image, video, text, audio, folder, other }

extension FileClassifyExtension on FileClassify {
  String get value {
    switch (this) {
      case FileClassify.image:
        return S.current.image;
      case FileClassify.video:
        return S.current.video;
      case FileClassify.text:
        return S.current.text;
      case FileClassify.audio:
        return S.current.audio;
      case FileClassify.folder:
        return S.current.folder;
      case FileClassify.other:
        return S.current.other;
    }
  }
}
