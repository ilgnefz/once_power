import 'dart:typed_data';

import 'file_enum.dart';

class FileInfo {
  String id;

  /// a
  String name;
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
  Resolution? resolution;
  Uint8List? thumbnail;
  String group;
  bool checked;

  FileInfo({
    required this.id,
    required this.name,
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
    required this.resolution,
    this.thumbnail,
    required this.group,
    required this.checked,
  });

  @override
  String toString() {
    return 'FileInfo{'
        'id: $id, '
        'name: $name, '
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
        'resolution: ${resolution.toString()}, '
        'thumbnail: $thumbnail, '
        'group: $group, '
        'checked: $checked}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
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
        'resolution': resolution?.toJson(),
        'thumbnail': thumbnail,
        'group': group,
        'checked': checked,
      };

  factory FileInfo.fromJson(Map<String, dynamic> json) => FileInfo(
        id: json['id'],
        name: json['name'],
        newName: json['newName'],
        parent: json['parent'],
        filePath: json['filePath'],
        tempPath: json['tempPath'],
        extension: json['extension'],
        newExtension: json['newExtension'],
        beforePath: json['beforePath'],
        createdDate: DateTime.fromMillisecondsSinceEpoch(json['createdDate']),
        modifiedDate: DateTime.fromMillisecondsSinceEpoch(json['modifiedDate']),
        exifDate: json['exifDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['exifDate'])
            : null,
        type: FileClassify.values[json['type']],
        size: json['size'],
        resolution: json['resolution'] != null
            ? Resolution.fromJson(json['resolution'])
            : null,
        thumbnail: json['thumbnail'],
        group: json['group'],
        checked: json['checked'],
      );
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

class Resolution {
  final int width;
  final int height;

  Resolution(this.width, this.height);

  static Resolution zero = Resolution(0, 0);

  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
      };

  factory Resolution.fromJson(Map<String, dynamic> json) => Resolution(
        json['width'],
        json['height'],
      );

  @override
  String toString() {
    return 'Resolution(width: $width, height: $height)';
  }
}
