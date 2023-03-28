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
  'ai',
  'bmp',
  'cdr',
  'dib',
  'dxf',
  'eps',
  'exif',
  'fpx',
  'gif',
  'heic',
  'jfif',
  'jpe',
  'jpeg',
  'jpg',
  'pcd',
  'pcx',
  'png',
  'psd',
  'svg',
  'tga',
  'tif',
  'tiff',
  'raw',
  'ufo',
  'webp',
];
final video = [
  '3gp',
  'asf',
  'avi',
  'dat',
  'f4v',
  'flv',
  'm3u8',
  'mkv',
  'mov',
  'mp4',
  'mpeg',
  'wmv',
  'rm',
  'rmvb',
  'ts'
];
final text = [
  'azw3',
  'doc',
  'docx',
  'epub',
  'md',
  'mobi',
  'pdf',
  'pptx',
  'txt',
  'xlsx'
];
final audio = ['aac', 'ape', 'flac', 'mp3', 'ogg', 'wav', 'wma'];
final folder = ['dir'];
