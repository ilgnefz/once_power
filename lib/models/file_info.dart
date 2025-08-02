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
  DateTime accessedDate;
  DateTime? exifDate;
  FileClassify type;
  int size;
  Resolution? resolution;
  FileMeteInfo? metaInfo;
  Uint8List? thumbnail;
  String group;
  bool checked;

  FileInfo({
    required this.id,
    required this.name,
    required this.newName,
    required this.parent,
    required this.filePath,
    this.tempPath = '',
    required this.extension,
    required this.newExtension,
    required this.beforePath,
    required this.createdDate,
    required this.modifiedDate,
    required this.accessedDate,
    this.exifDate,
    required this.type,
    required this.size,
    required this.resolution,
    required this.metaInfo,
    this.thumbnail,
    this.group = '',
    this.checked = true,
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
        'accessedDate: $accessedDate, '
        'exifDate: $exifDate, '
        'type: $type, '
        'size: $size, '
        'resolution: ${resolution.toString()}, '
        'metaInfo: ${metaInfo.toString()}, '
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
        'accessedDate': accessedDate.millisecondsSinceEpoch,
        'exifDate': exifDate?.millisecondsSinceEpoch,
        'type': type.index,
        'size': size,
        'resolution': resolution?.toJson(),
        'metaInfo': metaInfo?.toJson(),
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
        accessedDate: DateTime.fromMillisecondsSinceEpoch(json['accessedDate']),
        exifDate: json['exifDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['exifDate'])
            : null,
        type: FileClassify.values[json['type']],
        size: json['size'],
        resolution: json['resolution'] != null
            ? Resolution.fromJson(json['resolution'])
            : null,
        metaInfo: json['metaInfo'] != null
            ? FileMeteInfo.fromJson(json['metaInfo'])
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

class FileMeteInfo {
  String title;
  String artist;
  String album;
  String year;

  FileMeteInfo({
    this.title = '',
    this.artist = '',
    this.album = '',
    this.year = '',
  });

  FileMeteInfo copyWith({
    String? title,
    String? artist,
    String? album,
    String? year,
  }) {
    return FileMeteInfo(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'artist': artist,
        'album': album,
        'year': year,
      };

  factory FileMeteInfo.fromJson(Map<String, dynamic> json) => FileMeteInfo(
        title: json['title'],
        artist: json['artist'],
        album: json['album'],
        year: json['year'],
      );

  @override
  String toString() {
    return 'FileMeteInfo(title: $title, artist: $artist, album: $album, year: $year)';
  }
}
