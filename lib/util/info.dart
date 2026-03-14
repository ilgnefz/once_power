import 'package:once_power/const/extension.dart';
import 'package:once_power/core/sort.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/file.dart';
import 'package:string_util_xx/StringUtilxx.dart';

import 'format.dart';
import 'verify.dart';

bool getCompareResult(ComparisonOperator operator, String value, String info) {
  switch (operator) {
    case ComparisonOperator.contain:
      return info.contains(value);
    case ComparisonOperator.notContain:
      return !info.contains(value);
    case ComparisonOperator.equal:
      return info == value;
    case ComparisonOperator.notEqual:
      return info != value;
    case ComparisonOperator.before:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-01-01';
        }
        return DateTime.parse(info).isBefore(DateTime.parse(value));
      } catch (e) {
        return false;
      }
    case ComparisonOperator.after:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-12-31';
        }
        return DateTime.parse(info).isAfter(DateTime.parse(value));
      } catch (e) {
        return false;
      }
    case ComparisonOperator.beforeOrEqual:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-12-31';
        }
        DateTime infoDate = DateTime.parse(info);
        DateTime valueDate = DateTime.parse(value);
        return infoDate.isBefore(valueDate) ||
            infoDate.isAtSameMomentAs(valueDate);
      } catch (e) {
        return false;
      }
    case ComparisonOperator.afterOrEqual:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-01-01';
        }
        DateTime infoDate = DateTime.parse(info);
        DateTime valueDate = DateTime.parse(value);
        return infoDate.isAfter(valueDate) ||
            infoDate.isAtSameMomentAs(valueDate);
      } catch (e) {
        return false;
      }
  }
}

DateInfo? getDate(DateType type, FileInfo file) {
  switch (type) {
    case DateType.createdDate:
      return file.createdDate;
    case DateType.modifiedDate:
      return file.modifiedDate;
    case DateType.accessedDate:
      return file.accessedDate;
    case DateType.exifDate:
      return file.metaInfo?.capture;
    case DateType.earliestDate:
      return sortDateTime(file).first;
    case DateType.latestDate:
      return sortDateTime(file).last;
  }
}

DateInfo? getDateInfo(DateTime? date) {
  if (date == null) return null;
  DateInfo dateInfo = DateInfo(date, weekdayNames[date.weekday - 1]);
  return dateInfo;
}

String getDateName(DateTime? dateTime, int dateLen) {
  if (dateTime == null) return '';
  String date = formatDateTime(dateTime);
  return date.substring(0, dateLen > date.length ? date.length : dateLen);
}

FileClassify getFileClassify(String ext) {
  ext = ext.toLowerCase();
  if (AppExtension.image.contains(ext)) return FileClassify.image;
  if (AppExtension.video.contains(ext)) return FileClassify.video;
  if (AppExtension.doc.contains(ext)) return FileClassify.doc;
  if (AppExtension.audio.contains(ext)) return FileClassify.audio;
  if (AppExtension.archive.contains(ext)) return FileClassify.archive;
  // if (AppExtension.folder == ext) return FileClassify.folder;
  return FileClassify.other;
}

String getFullName(String name, String extension) {
  if (extension == '') return name;
  return '$name.$extension';
}

(int, int) getLenNum(String match, int nameLen) {
  int start = 0, end = 0;
  List<String> matchText = match.trim().split(' ');
  bool isDigit = matchText.every((e) => int.tryParse(e) != null);
  if (isDigit) {
    if (matchText.length == 1) {
      int first = int.parse(matchText.first);
      if (first > 0) end = first;
      if (first < 0) {
        start = nameLen + first;
        end = nameLen;
      }
    } else if (matchText.length > 1) {
      int first = int.parse(matchText.first);
      int last = int.parse(matchText.last);
      if (first > 0) start = first - 1;
      if (last > 0) end = last;
      if (first < 0) start = nameLen + first;
      if (last < 0) end = nameLen + last + 1;
    }
    start = start > nameLen - 1 ? nameLen - 1 : start;
    end = end > nameLen ? nameLen : end;
    if (end < start) start = 0;
  } else {
    end = match.length > nameLen ? nameLen : match.length;
  }
  return (start < 0 ? 0 : start, end < 0 ? 0 : end);
}

String getRuleTypeValue(InfoType type, FileInfo file) {
  switch (type) {
    case InfoType.name:
      return file.name;
    case InfoType.newName:
      return file.newName;
    case InfoType.folder:
      return file.parent;
    case InfoType.extension:
      return file.extension;
    case InfoType.createdDate:
      return file.createdDate.date.toString();
    case InfoType.modifiedDate:
      return file.modifiedDate.date.toString();
    case InfoType.accessedDate:
      return file.accessedDate.date.toString();
    case InfoType.capturedDate:
      return file.metaInfo?.capture?.date.toString() ?? '';
  }
}

List<FileInfo> splitSortList(List<FileInfo> fileList, bool reverse) {
  List<FileInfo> chineseList = [];
  List<FileInfo> otherList = [];
  for (FileInfo e in fileList) {
    if (isChinese(e.name)) {
      chineseList.add(e);
    } else {
      otherList.add(e);
    }
  }
  if (reverse) {
    chineseList.sort((a, b) => StringUtilxx_c.compareExtend(b.name, a.name));
    // otherList.sort((a, b) => b.name.compareTo(a.name));
    otherList.sort((a, b) => naturalCompare(b.name, a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => StringUtilxx_c.compareExtend(a.name, b.name));
  // otherList.sort((a, b) => a.name.compareTo(b.name));
  otherList.sort((a, b) => naturalCompare(a.name, b.name));
  return [...otherList, ...chineseList];
}

int naturalCompare(String a, String b) {
  if (a.isEmpty || b.isEmpty) {
    return a.length.compareTo(b.length);
  }

  final aFirstChar = a[0];
  final bFirstChar = b[0];

  final aIsDigit = aFirstChar.contains(RegExp(r'\d'));
  final bIsDigit = bFirstChar.contains(RegExp(r'\d'));

  if (aIsDigit && bIsDigit) {
    final regExp = RegExp(r'^\d+');
    final aMatch = regExp.firstMatch(a);
    final bMatch = regExp.firstMatch(b);

    if (aMatch != null && bMatch != null) {
      final aNum = int.tryParse(aMatch.group(0)!);
      final bNum = int.tryParse(bMatch.group(0)!);

      if (aNum != null && bNum != null) {
        final result = aNum.compareTo(bNum);
        if (result != 0) return result;
      }
    }

    return a.compareTo(b);
  } else if (aIsDigit) {
    return -1;
  } else if (bIsDigit) {
    return 1;
  } else {
    return a.compareTo(b);
  }
}
