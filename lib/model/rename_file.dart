import 'package:once_power/generated/l10n.dart';

class RenameFile {
  String id;
  String name;
  String newName;
  String parent;
  String extension;
  DateTime createDate;
  FileClassify type;
  bool checked;

  RenameFile({
    required this.id,
    required this.name,
    required this.newName,
    required this.parent,
    required this.extension,
    required this.createDate,
    required this.type,
    required this.checked,
  });

  @override
  String toString() {
    return 'RenameFile(id: $id, name: $name, newName: $newName, parent: $parent, extension: $extension, createDate: $createDate, type: $type, checked: $checked)';
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

final filter = ['ini', 'lnk'];

final image = [
  'jpg',
  'jpeg',
  'png',
  'gif',
  'bmp',
  'webp',
  'svg',
  'tiff',
  'pcx',
  'tga',
  'exif',
  'fpx',
  'psd',
  'cdr',
  'pcd',
  'dxf',
  'ufo',
  'eps',
  'ai',
  'raw'
];
final video = [
  'mp4',
  'avi',
  'mov',
  'wmv',
  'flv',
  'mpeg',
  '3gp',
  'asf',
  'rm',
  'rmvb',
  'f4v',
  'mkv',
  'm3u8',
  'ts'
];
final text = ['txt', 'doc', 'docx', 'pdf', 'xlsx', 'md', 'pptx'];
final audio = ['mp3', 'wma', 'wav', 'ape', 'flac', 'ogg', 'aac'];
final folder = ['dir'];
