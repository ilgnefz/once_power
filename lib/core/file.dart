import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:path/path.dart' as path;

void getFileInfo(WidgetRef ref, List<String> paths) {
  for (String p in paths) {
    String id = DateTime.now().toString() + p;
    String name = path.basenameWithoutExtension(p);
    String extension = path.extension(p);
    if (extension.startsWith('.')) extension = extension.substring(1);
    if (extension.isEmpty && name.startsWith('.')) {
      (name, extension) = ('', name.substring(1));
    }
    FileInfo file = FileInfo(
      id: id,
      name: name,
      newName: name,
      extension: extension,
      newExtension: extension,
      folder: path.dirname(p),
      path: p,
    );
    ref.read(fileListProvider.notifier).add(file);
  }
}
