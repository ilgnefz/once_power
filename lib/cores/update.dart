import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/normal.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:path/path.dart' as path;

import 'advance.dart';
import 'csv.dart';
import 'oplog.dart';

void updateName(WidgetRef ref) {
  if (ref.watch(cSVDataProvider).isNotEmpty) return csvDataRename(ref);
  FunctionMode mode = ref.watch(currentModeProvider);
  if (mode.isAdvance) return advanceUpdateName(ref);
  if (mode.isReplace) return normalUpdateName(ref, false);
  if (mode.isReserve) return normalUpdateName(ref, true);
}

Future<void> updateShowInfo(
  WidgetRef ref,
  FileInfo file,
  String newPath,
) async {
  String id = file.id;
  String newName = path.basenameWithoutExtension(newPath);
  String newExt = getExtension(newPath);
  if (ref.watch(isSaveLogProvider)) {
    String oldPath = path.basename(file.path);
    String newPath = getFullName(newName, newExt);
    await tempSaveLog(ref, oldPath, newPath);
  }
  if (file.name != newName) {
    ref.read(fileListProvider.notifier).updateOriginName(id, newName);
  }
  ref.read(fileListProvider.notifier).updatePath(id, newPath);
  if (file.ext != newExt) {
    ref.read(fileListProvider.notifier).updateOriginExt(id, newExt);
  }
  if (file.tempPath != '') {
    ref.read(fileListProvider.notifier).updateTempPath(id, '');
  }
}
