import 'package:flutter/cupertino.dart';

class FileInfo {
  String id;
  String name;
  String filePath;
  IconData icon;

  FileInfo(
      {required this.id,
      required this.name,
      required this.filePath,
      required this.icon});
  @override
  String toString() {
    return 'FileInfo(id: $id,name: $name, filePath: $filePath, icon: $icon)';
  }
}
