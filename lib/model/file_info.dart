import 'package:flutter/material.dart';

@immutable
class FileInfo {
  final String id;
  final String name;
  final String filePath;
  // IconData icon;

  const FileInfo({
    required this.id,
    required this.name,
    required this.filePath,
    // required this.icon,
  });

  @override
  String toString() {
    return 'FileInfo(id: $id,name: $name, filePath: $filePath)';
  }
}
