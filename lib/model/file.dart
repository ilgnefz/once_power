import 'dart:typed_data';

import 'package:once_power/enum/file.dart';
import 'package:once_power/util/info.dart';
import 'package:path/path.dart';

class FileInfo {
  final String id;

  /// a
  String name;
  String newName;

  /// C:\Photos
  String parent;

  /// C:\Photos\a.jpg
  String path;
  String tempPath;

  /// C:\Photos\a.jpg
  String beforePath;

  /// jpg
  String ext;
  String newExt;
  DateInfo createdDate;
  DateInfo modifiedDate;
  DateInfo accessedDate;
  FileClassify type;
  Resolution? resolution;
  FileMetaInfo? metaInfo;
  Uint8List? thumbnail;
  int size;
  String group;
  bool checked;

  FileInfo({
    required this.id,
    required this.name,
    required this.newName,
    required this.parent,
    required this.path,
    required this.tempPath,
    required this.beforePath,
    required this.ext,
    required this.newExt,
    required this.createdDate,
    required this.modifiedDate,
    required this.accessedDate,
    required this.resolution,
    required this.metaInfo,
    required this.thumbnail,
    required this.type,
    required this.size,
    this.group = '',
    this.checked = true,
  });

  FileInfo copyWith({
    String? name,
    String? newName,
    String? parent,
    String? path,
    String? tempPath,
    String? beforePath,
    String? ext,
    String? newExt,
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

  String getFullOldName() => getFullName(name, ext);

  String getFullNewName() => getFullName(newName, newExt);

  String getNewPath(bool isUndo) =>
      isUndo ? beforePath : join(parent, getFullNewName());
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
    capture: json['capture'] != null
        ? DateInfo.fromJson(json['capture'])
        : null,
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
