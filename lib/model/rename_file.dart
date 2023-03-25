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

enum FileClassify {
  image('图片'),
  video('视频'),
  text('文档'),
  audio('音频'),
  folder('文件夹'),
  other('其他');

  final String name;
  const FileClassify(this.name);
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
