import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/models/date.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/verify.dart';
import 'package:win32/win32.dart';

import 'notification.dart';

Future<void> modifyDate(WidgetRef ref) async {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> files = list.where((e) => e.checked).toList();
  int total = files.length;
  if (files.isEmpty) return;
  ref.read(totalProvider.notifier).update(total);
  ref.read(countProvider.notifier).reset();
  ref.read(isApplyingProvider.notifier).start();
  List<InfoDetail> errors = [];
  DateTime startTime = DateTime.now();

  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  for (FileInfo f in files) {
    if (!await fileExist(f)) {
      errors.add(InfoDetail(file: f.path, message: tr(AppL10n.errNoExist)));
      continue;
    }
    String filePath = f.path;
    DateTime? createdDate;
    DateTime? modifiedDate;
    DateTime? accessedDate;
    if (dateProperty.createdDateChecked) {
      createdDate = DateTime.tryParse(dateProperty.createdDate)?.toLocal();
    }
    if (dateProperty.modifiedDateChecked) {
      modifiedDate = DateTime.tryParse(dateProperty.modifiedDate)?.toLocal();
    }
    if (dateProperty.accessedDateChecked) {
      accessedDate = DateTime.tryParse(dateProperty.accessedDate)?.toLocal();
    }
    String? err = setTimeWin(
      filePath,
      creationTime: createdDate,
      lastWriteTime: modifiedDate,
      lastAccessTime: accessedDate,
    );
    if (err != null) {
      errors.add(InfoDetail(file: f.name, message: err));
      continue;
    }
    ref
        .read(fileListProvider.notifier)
        .updateDate(f.id, createdDate, modifiedDate, accessedDate);
  }
  Duration duration = DateTime.now().difference(startTime);
  double cost = duration.inMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  showDateModifyNotification(errors, total);
}

String? setTimeWin(
  String path, {
  DateTime? creationTime,
  DateTime? lastWriteTime,
  DateTime? lastAccessTime,
}) {
  final nativePath = path.toNativeUtf16();

  // 检查路径是文件还是文件夹
  final attributes = GetFileAttributes(nativePath);
  // if (attributes == INVALID_FILE_ATTRIBUTES) {
  //   free(nativePath);
  //   return '路径不存在';
  // }

  final isDirectory = (attributes & FILE_ATTRIBUTE_DIRECTORY) != 0;

  final handle = CreateFile(
    nativePath,
    GENERIC_WRITE,
    0,
    nullptr,
    OPEN_EXISTING,
    isDirectory ? FILE_FLAG_BACKUP_SEMANTICS : FILE_ATTRIBUTE_NORMAL,
    NULL,
  );

  if (handle == INVALID_HANDLE_VALUE) {
    free(nativePath);
    return tr(AppL10n.errNoOpen, namedArgs: {'file': nativePath.toString()});
  }

  try {
    final creationPtr = creationTime != null
        ? creationTime.toFileTime()
        : nullptr;
    final writePtr = lastWriteTime != null
        ? lastWriteTime.toFileTime()
        : nullptr;
    final accessPtr = lastAccessTime != null
        ? lastAccessTime.toFileTime()
        : nullptr;

    if (SetFileTime(handle, creationPtr, accessPtr, writePtr) == FALSE) {
      return tr(
        AppL10n.errModifyDateFail,
        namedArgs: {'file': nativePath.toString()},
      );
    }

    return null; // 成功返回null
  } finally {
    CloseHandle(handle);
    free(nativePath);
  }
}

extension DateTimeExtension on DateTime {
  Pointer<FILETIME> toFileTime() {
    final fileTime = calloc<FILETIME>();
    final systemTime = calloc<SYSTEMTIME>();

    // 转换为UTC时间
    final utcTime = toUtc();

    systemTime.ref
      ..wYear = utcTime.year
      ..wMonth = utcTime.month
      ..wDay = utcTime.day
      ..wHour = utcTime.hour
      ..wMinute = utcTime.minute
      ..wSecond = utcTime.second
      ..wMilliseconds = 0;

    SystemTimeToFileTime(systemTime, fileTime);
    calloc.free(systemTime);

    return fileTime;
  }
}
