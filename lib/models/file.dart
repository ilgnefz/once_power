import 'dart:typed_data';

import 'package:once_power/enums/file.dart';

class FileInfo {
  String id;

  /// a
  String name;
  String newName;

  /// C:\Photos
  String parent;

  /// C:\Photos\a.jpg
  String path;
  String tempPath;

  /// jpg
  String ext;
  String newExt;

  /// C:\Photos\a.jpg
  String beforePath;
  DateInfo createdDate;
  DateInfo modifiedDate;
  DateInfo accessedDate;
  FileClassify type;
  int size;
  Resolution? resolution;
  FileMetaInfo? metaInfo;
  Uint8List? thumbnail;
  String group;
  bool checked;

  FileInfo({
    required this.id,
    required this.name,
    required this.newName,
    required this.parent,
    required this.path,
    this.tempPath = '',
    required this.ext,
    required this.newExt,
    required this.beforePath,
    required this.createdDate,
    required this.modifiedDate,
    required this.accessedDate,
    required this.type,
    required this.size,
    required this.resolution,
    required this.metaInfo,
    required this.thumbnail,
    this.group = '',
    this.checked = true,
  });

  FileInfo copyWith({
    String? name,
    String? newName,
    String? parent,
    String? path,
    String? tempPath,
    String? ext,
    String? newExt,
    String? beforePath,
    DateInfo? createdDate,
    DateInfo? modifiedDate,
    DateInfo? accessedDate,
    Resolution? resolution,
    FileMetaInfo? metaInfo,
    Uint8List? thumbnail,
    String? group,
    bool? checked,
  }) {
    return FileInfo(
      id: id,
      name: name ?? this.name,
      newName: newName ?? this.newName,
      parent: parent ?? this.parent,
      path: path ?? this.path,
      tempPath: tempPath ?? this.tempPath,
      ext: ext ?? this.ext,
      newExt: newExt ?? this.newExt,
      beforePath: beforePath ?? this.beforePath,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      accessedDate: accessedDate ?? this.accessedDate,
      type: type,
      size: size,
      resolution: resolution ?? this.resolution,
      metaInfo: metaInfo ?? this.metaInfo,
      thumbnail: thumbnail ?? this.thumbnail,
      group: group ?? this.group,
      checked: checked ?? this.checked,
    );
  }

  // toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'newName': newName,
        'parent': parent,
        'path': path,
        'tempPath': tempPath,
        'ext': ext,
        'newExt': newExt,
        'beforePath': beforePath,
        'createdDate': createdDate.toJson(),
        'modifiedDate': modifiedDate.toJson(),
        'accessedDate': accessedDate.toJson(),
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
        path: json['path'],
        tempPath: json['tempPath'],
        ext: json['ext'],
        newExt: json['newExt'],
        beforePath: json['beforePath'],
        createdDate: DateInfo.fromJson(json['createdDate']),
        modifiedDate: DateInfo.fromJson(json['modifiedDate']),
        accessedDate: DateInfo.fromJson(json['accessedDate']),
        type: FileClassify.values[json['type']],
        size: json['size'],
        resolution: json['resolution'] != null
            ? Resolution.fromJson(json['resolution'])
            : null,
        metaInfo: json['metaInfo'] != null
            ? FileMetaInfo.fromJson(json['metaInfo'])
            : null,
        thumbnail: json['thumbnail'],
        group: json['group'],
        checked: json['checked'],
      );

  @override
  String toString() {
    return 'FileInfo{id: $id, name: $name, newName: $newName, '
        'parent: $parent, path: $path, tempPath: $tempPath, ext: $ext, '
        'newExt: $newExt, beforePath: $beforePath, createdDate: $createdDate,'
        ' modifiedDate: $modifiedDate, accessedDate: $accessedDate,'
        ' type: $type, size: $size, resolution: $resolution,'
        ' metaInfo: $metaInfo, thumbnail: $thumbnail, '
        'group: $group, checked: $checked}';
  }
}

class DateInfo {
  DateTime date;
  List<String> weekday;

  DateInfo(this.date, this.weekday);

  Map<String, dynamic> toJson() => {
        'date': date.millisecondsSinceEpoch,
        'weekday': weekday,
      };

  factory DateInfo.fromJson(Map<String, dynamic> json) => DateInfo(
        DateTime.fromMillisecondsSinceEpoch(json['date']),
        json['weekday'],
      );

  @override
  String toString() {
    return 'DateInfo(date: $date, weekday: $weekday)';
  }
}

class Resolution {
  final int width;
  final int height;

  Resolution(this.width, this.height);

  static Resolution zero = Resolution(0, 0);

  Map<String, dynamic> toJson() => {'width': width, 'height': height};

  factory Resolution.fromJson(Map<String, dynamic> json) =>
      Resolution(json['width'], json['height']);

  @override
  String toString() {
    return 'Resolution(width: $width, height: $height)';
  }
}

class FileMetaInfo {
  String title;
  String artist;
  String album;
  String year;
  DateInfo? capture;
  String make;
  String model;
  double? longitude;
  double? latitude;
  String location;

  FileMetaInfo({
    this.title = '',
    this.artist = '',
    this.album = '',
    this.year = '',
    this.capture,
    this.make = '',
    this.model = '',
    this.longitude,
    this.latitude,
    this.location = '',
  });

  FileMetaInfo copyWith({
    String? title,
    String? artist,
    String? album,
    String? year,
    DateInfo? capture,
    String? make,
    String? model,
    double? longitude,
    double? latitude,
    String? location,
  }) {
    return FileMetaInfo(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      year: year ?? this.year,
      capture: capture ?? this.capture,
      make: make ?? this.make,
      model: model ?? this.model,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'artist': artist,
        'album': album,
        'year': year,
        'capture': capture?.toJson(),
        'make': make,
        'model': model,
        'longitude': longitude,
        'latitude': latitude,
        'location': location,
      };

  factory FileMetaInfo.fromJson(Map<String, dynamic> json) => FileMetaInfo(
        title: json['title'],
        artist: json['artist'],
        album: json['album'],
        year: json['year'],
        capture:
            json['capture'] != null ? DateInfo.fromJson(json['capture']) : null,
        make: json['make'],
        model: json['model'],
        longitude: json['longitude'],
        latitude: json['latitude'],
        location: json['location'],
      );

  @override
  String toString() {
    return 'FileMetaInfo(title: $title, artist: $artist, '
        'album: $album, year: $year, capture: $capture, make: $make, '
        'model: $model, longitude: $longitude, latitude: $latitude, '
        'location: $location)';
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

  UploadMarkInfo copyWith({String? name, String? content, bool? isPrefix}) {
    return UploadMarkInfo(
      name: name ?? this.name,
      content: content ?? this.content,
      isPrefix: isPrefix ?? this.isPrefix,
    );
  }

  @override
  String toString() {
    return 'UploadMarkInfo{name: $name, content: $content, isPrefix: $isPrefix}';
  }
}
