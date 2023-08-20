import 'dart:io';

import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_file.g.dart';

@riverpod
class FileList extends _$FileList {
  @override
  List<RenameFile> build() => [];

  void add(RenameFile file) => state = [...state, file];
  void clear() => state = [];
}

// FileClassify getFileClassify(String extension) {
//   if (image.contains(extension)) return FileClassify.image;
//   if (video.contains(extension)) return FileClassify.video;
//   if (text.contains(extension)) return FileClassify.text;
//   if (audio.contains(extension)) return FileClassify.audio;
//   return FileClassify.other;
// }
//
// @riverpod
// class CurrentFileClassify extends _$CurrentFileClassify {
//   @override
//   FileClassify build() => FileClassify.other;
//   void update(String extension) => state = getFileClassify(extension);
// }

@riverpod
FileClassify getFileClassify(GetFileClassifyRef ref, String extension) {
  if (image.contains(extension)) return FileClassify.image;
  if (video.contains(extension)) return FileClassify.video;
  if (text.contains(extension)) return FileClassify.text;
  if (audio.contains(extension)) return FileClassify.audio;
  return FileClassify.other;
}

@riverpod
List<String> getAllFile(GetAllFileRef ref, String folder) {
  Directory directory = Directory(folder);
  List<String> children = [];
  List<FileSystemEntity> files = directory.listSync(recursive: true);
  for (var file in files) {
    if (FileSystemEntity.isFileSync(file.path)) {
      String extension = path.extension(file.path);
      extension = extension == '' ? extension : extension.substring(1);
      if (!filter.contains(extension)) children.add(file.path);
    }
  }
  return children;
}
