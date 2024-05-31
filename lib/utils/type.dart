import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/model/types.dart';
import 'package:path/path.dart' as path;

IconData getFileIcon(String extension) {
  if (folder == extension) return Icons.folder_rounded;
  if (image.contains(extension)) return Icons.image_rounded;
  if (video.contains(extension)) return Icons.movie_creation_rounded;
  if (text.contains(extension)) return Icons.text_snippet_rounded;
  if (audio.contains(extension)) return Icons.audiotrack_rounded;
  if (zip.contains(extension)) return Icons.backpack_rounded;
  return Icons.question_mark_rounded;
}

String getFileClassifyName(String extension) {
  if (folder == extension) return 'folder';
  if (image.contains(extension)) return 'image';
  if (video.contains(extension)) return 'video';
  if (text.contains(extension)) return 'text';
  if (audio.contains(extension)) return 'audio';
  if (zip.contains(extension)) return 'zip';
  return 'other';
}

String getFileExtension(String filePath) {
  bool isFile = FileSystemEntity.isFileSync(filePath);
  String extension = 'dir';
  if (isFile) {
    extension = path.extension(filePath);
    if (extension != '') extension = extension.substring(1);
  }
  return extension;
}
