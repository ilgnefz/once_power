import 'enum.dart';
import 'file_info.dart';

final filter = ['ini', 'lnk'];

final audio = [
  'aac',
  'ape',
  'cda',
  'flac',
  'midi',
  'mp3',
  'ogg',
  'ra',
  'rm',
  'rmx',
  'sacd',
  'vqf',
  'wav',
  'wma'
];
final doc = [
  'azw3',
  'accdb',
  'doc',
  'docx',
  'csv',
  'epub',
  'et',
  'log',
  'md',
  'mdx',
  'mobi',
  'ods',
  'odt',
  'odp',
  'oplog',
  'pdf',
  'ppt',
  'pptm',
  'pptx',
  'rtf',
  'txt',
  'wps',
  'xls',
  'xlsm',
  'xlsx',
];
final image = [
  'ai',
  'apng',
  'bmp',
  'cdr',
  'dib',
  'dxf',
  'eps',
  'exif',
  'fpx',
  'gif',
  'heic',
  'ico',
  'jfif',
  'jpe',
  'jpeg',
  'jpg',
  'pcd',
  'pcx',
  'png',
  'psd',
  'pvr',
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
  '3g2',
  'asf',
  'avi',
  'dat',
  'f4v',
  'flv',
  'm3u8',
  'm4v',
  'mkv',
  'mov',
  'mp4',
  'mpeg',
  'mpg',
  'webm',
  'wmv',
  'rm',
  'rmvb',
  'ts'
];
final zip = ['zip', 'rar', '7z', 'tar', 'gz', 'bz2', 'iso', 'dmg'];
const String folder = 'dir';

FileInfo nullFile = FileInfo(
  id: '',
  name: '',
  phonetic: '',
  newName: '',
  parent: '',
  filePath: '',
  extension: '',
  newExtension: '',
  beforePath: '',
  createdDate: DateTime.now(),
  modifiedDate: DateTime.now(),
  type: FileClassify.other,
  checked: false,
);

// Map<String, Map<String, List<String>>> map = {
//     "today": {"image": [], "video": []},
//     "yesterday": {"image": [], "video": []},
//   };
typedef DateFormatMap = Map<String, Map<String, List<String>>>;
