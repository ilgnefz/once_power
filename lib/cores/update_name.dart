import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:path/path.dart' as path;

import 'csv_rename.dart';
import 'oplog.dart';
import 'rename_replace.dart';
import 'rename_reserve.dart';

void updateName(WidgetRef ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool hasCSV = ref.watch(cSVDataProvider).isNotEmpty;
  if (hasCSV) {
    // print('core/rename: 我来了 CSV');
    // resetExtension(ref);
    cSVDataRename(ref);
  }
  if (mode.isAdvance && !hasCSV) {
    // print('core/rename: 我来了 Advance');
    // resetExtension(ref);
    advanceUpdateName(ref);
  }
  if ((mode.isReplace || mode.isReserve) && !hasCSV) {
    // print('core/rename: 我来了 Normal');
    normalUpdateName(ref);
  }
  updateExtension(ref);
}

void updateExtension(WidgetRef ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool hasCSV = ref.watch(cSVDataProvider).isNotEmpty;
  bool modify = ref.watch(isModifyExtensionProvider);
  bool needUpdate = (mode.isReplace || mode.isReserve) && !hasCSV && modify;
  for (FileInfo file in ref.watch(fileListProvider)) {
    String extension = file.extension;
    if (needUpdate && file.checked) {
      extension = ref.watch(extensionControllerProvider).text;
    }
    ref.read(fileListProvider.notifier).updateExtension(file.id, extension);
  }
}

void normalUpdateName(WidgetRef ref) {
  List<FileInfo> list = ref.watch(sortListProvider);
  FunctionMode mode = ref.watch(currentModeProvider);
  bool isDate = ref.watch(isDateRenameProvider);
  int index = 0;
  String name = '';
  bool isCyclePrefix = ref.watch(isCyclePrefixProvider);
  bool isCycleSuffix = ref.watch(isCycleSuffixProvider);
  var (swapPrefix, prefixStr, pStartSerial, ppSerialLen) = getPrefixInfo(ref);
  var (swapSuffix, suffixStr, sStartSerial, sSerialLen) = getSuffixInfo(ref);
  Map<String, dynamic> classifyMap = {};
  for (FileInfo file in list) {
    if (!file.checked) {
      ref.read(fileListProvider.notifier).updateName(file.id, file.name);
      continue;
    }
    String newPrefix = prefixStr, newSuffix = suffixStr;
    String? filePrefix = filePrefixStr(ref, isCyclePrefix, index);
    String? fileSuffix = fileSuffixStr(ref, isCycleSuffix, index);
    if (filePrefix != null) newPrefix = filePrefix + newPrefix;
    if (fileSuffix != null) newSuffix = newSuffix + fileSuffix;
    String prefix = getMarkStr(ref, isDate, swapPrefix, newPrefix, pStartSerial,
        ppSerialLen, index, file, classifyMap);
    String suffix = getMarkStr(ref, isDate, swapSuffix, newSuffix, sStartSerial,
        sSerialLen, index, file, classifyMap);
    if (mode.isReplace) {
      String modify = isDate
          ? dateName(ref, file)
          : ref.watch(modifyControllerProvider).text;
      name = replaceModeName(ref, file.name, modify);
    }
    if (mode.isReserve) {
      name = isDate ? dateName(ref, file) : reserveModeName(ref, file.name);
    }
    name = prefix + name + suffix;
    ref.read(fileListProvider.notifier).updateName(file.id, name);
    index++;
  }
}

Future<void> updateShowInfo(
    WidgetRef ref, FileInfo file, String newPath) async {
  String id = file.id;
  String newName = path.basenameWithoutExtension(newPath);
  String newExtension = getExtension(newPath);
  if (ref.watch(isSaveLogProvider)) {
    String oldPath = path.basename(file.filePath);
    String newPath = getNameWithExt(newName, newExtension);
    await tempSaveLog(ref, oldPath, newPath);
  }
  if (file.name != newName) {
    ref.read(fileListProvider.notifier).updateOriginName(id, newName);
  }
  ref.read(fileListProvider.notifier).updateFilePath(id, newPath);
  // ref.read(fileListProvider.notifier).updateExtension(id, newExtension);
  if (file.extension != newExtension) {
    ref.read(fileListProvider.notifier).updateOriginExtension(id, newExtension);
  }
  if (file.tempPath != '') {
    ref.read(fileListProvider.notifier).updateTempPath(id, '');
  }
  // updateExtension(ref, file);
}
