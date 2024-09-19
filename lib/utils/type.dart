import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/types.dart';
import 'package:path/path.dart' as path;

IconData getFileIcon(String extension) {
  if (folder == extension) return Icons.folder_rounded;
  if (image.contains(extension)) return Icons.image_rounded;
  if (video.contains(extension)) return Icons.movie_creation_rounded;
  if (doc.contains(extension)) return Icons.text_snippet_rounded;
  if (audio.contains(extension)) return Icons.audiotrack_rounded;
  if (zip.contains(extension)) return Icons.backpack_rounded;
  return Icons.question_mark_rounded;
}

FileClassify getFileClassify(String extension) {
  extension = extension.toLowerCase();
  if (audio.contains(extension)) return FileClassify.audio;
  if (folder == extension) return FileClassify.folder;
  if (image.contains(extension)) return FileClassify.image;
  if (doc.contains(extension)) return FileClassify.doc;
  if (video.contains(extension)) return FileClassify.video;
  if (zip.contains(extension)) return FileClassify.zip;
  return FileClassify.other;
}

String getFileClassifyName(FileClassify classify) {
  switch (classify) {
    case FileClassify.audio:
      return 'audio';
    case FileClassify.folder:
      return 'folder';
    case FileClassify.image:
      return 'image';
    case FileClassify.doc:
      return 'text';
    case FileClassify.video:
      return 'video';
    case FileClassify.zip:
      return 'zip';
    default:
      return 'other';
  }
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

bool isChinese(String text) => RegExp(r'[\u4e00-\u9fff]').hasMatch(text);
