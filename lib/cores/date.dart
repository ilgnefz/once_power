import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/date.dart';
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
  int count = 0;
  for (FileInfo f in files) {
    if (!await fileExist(f)) {
      errors.add(InfoDetail(file: f.path, message: tr(AppL10n.errNoExist)));
      continue;
    }
    String filePath = f.path;
    DateDiffType diffType = dateProperty.diffType;
    int interval =
        diffType.isAdd ? dateProperty.interval : -dateProperty.interval;
    interval *= count;
    DateTimeUnit dateUnit = dateProperty.dateUnit;
    bool fullReplace = dateProperty.fullReplace;
    DateTime? createdDate;
    DateTime? modifiedDate;
    DateTime? accessedDate;
    if (dateProperty.createdDateChecked) {
      createdDate = finalDate(dateProperty.createdDate, fullReplace, interval,
          dateUnit, f.createdDate.date);
    }
    if (dateProperty.modifiedDateChecked) {
      modifiedDate = finalDate(dateProperty.modifiedDate, fullReplace, interval,
          dateUnit, f.modifiedDate.date);
    }
    if (dateProperty.accessedDateChecked) {
      accessedDate = finalDate(dateProperty.accessedDate, fullReplace, interval,
          dateUnit, f.accessedDate.date);
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
    count++;
  }
  Duration duration = DateTime.now().difference(startTime);
  double cost = duration.inMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  showDateModifyNotification(errors, total);
}

DateTime? finalDate(String? date, bool fullReplace, int interval,
    DateTimeUnit dateUnit, DateTime original) {
  if (date == null) return null;
  DateTime? parsedDate = DateTime.tryParse(date)?.toLocal();
  if (parsedDate == null) return null;
  if (fullReplace) {
    parsedDate = parsedDate.copyWith(
      year: parsedDate.year == 0 ? 1970 : parsedDate.year,
    );
  } else {
    bool useOriginalDate = parsedDate.year == 0;
    int year = useOriginalDate ? original.year : parsedDate.year;
    int month = useOriginalDate ? original.month : parsedDate.month;
    int day = useOriginalDate ? original.day : parsedDate.day;

    bool useOriginalTime = parsedDate.hour == 0 &&
        parsedDate.minute == 0 &&
        parsedDate.second == 0;
    int hour = useOriginalTime ? original.hour : parsedDate.hour;
    int minute = useOriginalTime ? original.minute : parsedDate.minute;
    int second = useOriginalTime ? original.second : parsedDate.second;

    bool isDate = dateUnit.isYear || dateUnit.isMonth || dateUnit.isDay;

    if ((useOriginalDate && isDate) || (useOriginalTime && !isDate)) {
      interval = 0;
    }

    parsedDate = parsedDate.copyWith(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
    );
  }
  return interval == 0
      ? parsedDate
      : parsedDate.addSingleUnit(dateUnit, interval);
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
    final creationPtr =
        creationTime != null ? creationTime.toFileTime() : nullptr;
    final writePtr =
        lastWriteTime != null ? lastWriteTime.toFileTime() : nullptr;
    final accessPtr =
        lastAccessTime != null ? lastAccessTime.toFileTime() : nullptr;

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
