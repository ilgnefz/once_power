import 'dart:io';
import 'package:path/path.dart' as path;

String? getUsername() {
  if (Platform.isWindows) {
    return Platform.environment['USERNAME'];
  }
  return null;
}

String getTopPath(String filePath) {
  String separator = Platform.isWindows ? '\\' : '/';
  List<String> pathList = filePath.split(separator);
  String disk = pathList.first;
  String topPath = path.join(pathList.first, pathList[1]);
  if (Platform.isWindows && disk == 'C:') {
    List<String> diskFolders = [
      'Videos',
      'Pictures',
      'Documents',
      'Downloads',
      'Music',
      'Desktop',
      '3D Objects'
    ];
    if (diskFolders.contains(pathList[3])) {
      topPath = path.join(topPath, pathList[2], pathList[3]);
    }
  }
  return topPath;
}

// List<(String, bool)> getParentPath(String filePath) {
//   List<(String, bool)> list = [];
//   String separator = Platform.isWindows ? '\\' : '/';
//   String parentPath = path.dirname(filePath);
//   List<String> parentFolders = parentPath.split(separator);
//   for (int i = 1; i < parentFolders.length - 1; i++) {
//     String folderPath = parentFolders.sublist(0, i + 1).join('/');
//     if (Directory(folderPath).listSync().length == 1) {
//       if (Directory(folderPath).listSync().first is Directory) {
//         list.add((folderPath, false));
//       } else {
//         list.add((folderPath, true));
//       }
//     } else {
//       list.add((folderPath, false));
//     }
//   }
//   return list;
// }

bool fileTrueExists(String filePath) {
  String parentPath = path.dirname(filePath);
  List<FileSystemEntity> files = Directory(parentPath).listSync();
  for (FileSystemEntity f in files) {
    if (f.path == filePath) return true;
  }
  return false;
}
