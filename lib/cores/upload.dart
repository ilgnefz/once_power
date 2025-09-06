import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/cores/update.dart';

Future<void> uploadFile(WidgetRef ref) async {
  final List<XFile> files = await openFiles();
  if (files.isNotEmpty) {
    await formatXFile(ref, files);
    updateName(ref);
  }
}

Future<void> uploadFolder(WidgetRef ref) async {
  final List<String?> folders = await getDirectoryPaths();
  if (folders.isNotEmpty) {
    await formatFolder(ref, folders);
    updateName(ref);
  }
}

void dropFile(DropDoneDetails details, WidgetRef ref) async {
  List<XFile> paths = details.files;
  if (paths.isNotEmpty) {
    final files = paths.map((e) => e.path).toList();
    await formatPath(ref, files);
    updateName(ref);
  }
}
