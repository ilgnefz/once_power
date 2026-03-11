import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/verify.dart';

Future<void> updateDate(WidgetRef ref) async {
  Stopwatch stopwatch = Stopwatch()..start();
  List<FileInfo> list = ref.read(fileListProvider);
  List<FileInfo> files = list.where((e) => e.checked).toList();
  int total = files.length;
  if (files.isEmpty) return;
  ref.read(totalProvider.notifier).update(total);
  ref.read(countProvider.notifier).reset();
  ref.read(isApplyingProvider.notifier).start();
  List<InfoDetail> errors = [];
  DateProperty dateProperty = ref.read(fileDatePropertyProvider);
  final FileList provider = ref.read(fileListProvider.notifier);
  bool selfAdjust = dateProperty.selfAdjust;
  DateDiffType diffType = dateProperty.diffType;
  DateTimeUnit dateUnit = dateProperty.dateUnit;
  bool fullReplace = dateProperty.fullReplace;
  int count = 0;
  for (FileInfo f in files) {
    if (!await isExist(f.type.isFolder, f.path)) {
      errors.add(InfoDetail(file: f.path, message: tr(AppL10n.errNoExist)));
      continue;
    }
    String filePath = f.path;
    int interval = diffType.isAdd
        ? dateProperty.interval
        : -dateProperty.interval;
    interval = selfAdjust ? interval : interval * count;
    DateTime? createdDate;
    DateTime? modifiedDate;
    DateTime? accessedDate;
    if (dateProperty.createdDateChecked) {
      createdDate = selfAdjust
          ? f.createdDate.date.addSingleUnit(dateUnit, interval)
          : finalDate(
              dateProperty.createdDate,
              fullReplace,
              interval,
              dateUnit,
              f.createdDate.date,
            );
    }
    if (dateProperty.modifiedDateChecked) {
      modifiedDate = selfAdjust
          ? f.modifiedDate.date.addSingleUnit(dateUnit, interval)
          : finalDate(
              dateProperty.modifiedDate,
              fullReplace,
              interval,
              dateUnit,
              f.modifiedDate.date,
            );
    }
    if (dateProperty.accessedDateChecked) {
      accessedDate = selfAdjust
          ? f.accessedDate.date.addSingleUnit(dateUnit, interval)
          : finalDate(
              dateProperty.accessedDate,
              fullReplace,
              interval,
              dateUnit,
              f.accessedDate.date,
            );
    }
    if (createdDate != null) {
      try {
        int timestamp = createdDate.millisecondsSinceEpoch ~/ 1000;
        setCtime(filePath: filePath, time: timestamp);
        provider.updateCreatedDate(f.id, createdDate);
      } catch (e) {
        errors.add(InfoDetail(file: f.name, message: e.toString()));
      }
    }
    if (modifiedDate != null) {
      try {
        int timestamp = modifiedDate.millisecondsSinceEpoch ~/ 1000;
        setMtime(filePath: filePath, time: timestamp);
        provider.updateModifiedDate(f.id, modifiedDate);
      } catch (e) {
        errors.add(InfoDetail(file: f.name, message: e.toString()));
      }
    }
    if (accessedDate != null) {
      try {
        int timestamp = accessedDate.millisecondsSinceEpoch ~/ 1000;
        setAtime(filePath: filePath, time: timestamp);
        provider.updateAccessedDate(f.id, accessedDate);
      } catch (e) {
        errors.add(InfoDetail(file: f.name, message: e.toString()));
      }
    }
    count++;
    ref.read(countProvider.notifier).update();
  }
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  showDateModifyNotification(errors, total);
}

DateTime? finalDate(
  String? date,
  bool fullReplace,
  int interval,
  DateTimeUnit dateUnit,
  DateTime original,
) {
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

    bool useOriginalTime =
        parsedDate.hour == 0 &&
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
