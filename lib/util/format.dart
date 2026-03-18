import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/file.dart';

String convertToLocalTime(String utcTimeStr) {
  try {
    // 检查是否包含UTC前缀并移除
    String cleanTimeStr = utcTimeStr;
    if (utcTimeStr.startsWith('UTC ')) {
      cleanTimeStr = utcTimeStr.substring(4);
    }

    // 解析时间字符串（格式：YYYY-MM-DD HH:mm:ss）
    List<String> parts = cleanTimeStr.split(' ');
    if (parts.length != 2) {
      return utcTimeStr; // 如果格式不符合预期，返回原始字符串
    }

    List<String> dateParts = parts[0].split('-');
    List<String> timeParts = parts[1].split(':');

    if (dateParts.length != 3 || timeParts.length != 3) {
      return utcTimeStr; // 如果格式不符合预期，返回原始字符串
    }

    // 构建DateTime对象
    DateTime utcDateTime = DateTime.utc(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      int.parse(timeParts[2]),
    );

    // 转换为本地时间
    DateTime localDateTime = utcDateTime.toLocal();
    // 格式化为标准字符串（可以根据需要调整格式）
    return localDateTime.toString().substring(0, 19); // 格式：YYYY-MM-DD HH:mm:ss
  } catch (e) {
    // 如果解析失败，返回原始字符串
    debugPrint('时间转换失败: $e');
    return utcTimeStr;
  }
}

int extractNum(String value) {
  final match = RegExp(r'\d+').firstMatch(value);
  final currentValue = match != null ? int.parse(match.group(0)!) : 0;
  return currentValue;
}

String formatDateTime(DateTime dateTime) {
  String m = formatTimeNum(dateTime.month);
  String d = formatTimeNum(dateTime.day);
  String h = formatTimeNum(dateTime.hour);
  String min = formatTimeNum(dateTime.minute);
  String s = formatTimeNum(dateTime.second);
  return '${dateTime.year}$m$d$h$min$s';
}

String formatFileSize(int bytes, {int precision = 2}) {
  const List<String> units = ['B', 'KB', 'MB', 'GB'];
  double size = bytes.toDouble();
  int unitIndex = 0;

  while (size >= 1024 && unitIndex < units.length - 1) {
    size /= 1024;
    unitIndex++;
  }

  switch (units[unitIndex]) {
    case 'B':
      return '$bytes B';
    case 'KB':
      return '${size.toStringAsFixed(1)} KB';
    default:
      return '${size.toStringAsFixed(precision)} ${units[unitIndex]}';
  }
}

String formatNum(int n, int width) {
  if (width == 0) return '';
  if (n.toString().length > width) return n.toString();
  return n.toString().padLeft(width, '0');
}

String formatResolution(Resolution resolution) =>
    '${resolution.width} x ${resolution.height}';

String formatTimeNum(int num) => num.toString().padLeft(2, '0');

String formatModifyDate(String date, bool fullReplace, bool selfAdjust) {
  if (selfAdjust) return 'XXXX-XX-XX XX:XX:XX.XXX';
  if (fullReplace) {
    if (date.startsWith('0000-')) date = date.replaceFirst('0000', '1970');
    return date;
  }
  if (date.startsWith('0000-01-01')) {
    date = date.replaceFirst('0000-01-01', 'XXXX-XX-XX');
  }
  return date.replaceFirst('00:00:00.000', 'XX:XX:XX.XXX');
}

DateTime intToDateTime(int time) =>
    DateTime.fromMillisecondsSinceEpoch(time * 1000);

/// 删除文件名中的禁止字符
String removeForbiddenCharacters(String fileName) {
  // Windows系统中文件名禁止的字符 < > : " / \ | ? *
  // 注意：! @ # $ % ^ & ( ) 等字符
  return fileName
      .replaceAll('<', '[')
      .replaceAll('>', ']')
      .replaceAll(':', '-')
      .replaceAll('"', "'")
      .replaceAll('/', '&')
      .replaceAll('\\', '&')
      .replaceAll('|', '&')
      .replaceAll('?', '')
      .replaceAll('*', '');
}

List<String> stringToList(String content) {
  List<String> list = [];
  if (content.contains('\n')) {
    List<String> tempList = content.split('\n');
    for (String i in tempList) {
      if (i.contains('\r')) {
        list.add(i.replaceAll('\r', ''));
      } else {
        list.add(i);
      }
    }
  }
  if (!content.contains('\n') && content.contains(' ')) {
    list.addAll(content.trim().split(' '));
  }
  return list;
}

String formatSystemError(Object e) {
  if (e.runtimeType == PathNotFoundException) {
    e as PathNotFoundException;
    return e.osError?.message ?? tr(AppL10n.errNotExists);
  }
  if (e.runtimeType == PathAccessException) {
    e as PathAccessException;
    return e.osError?.message ?? e.message;
  }
  if (e.runtimeType == PathExistsException) {
    e as PathAccessException;
    return e.osError?.message ?? e.message;
  }
  return e.toString();
}

String formatVideoTime(Duration total, Duration current) {
  String currentM = formatTimeNum(current.inMinutes);
  String currentS = formatTimeNum(current.inSeconds.remainder(60));
  String totalM = formatTimeNum(total.inMinutes);
  String totalS = formatTimeNum(total.inSeconds.remainder(60));
  return '$currentM:$currentS / $totalM:$totalS';
}

String formatShowDate(String date, DateStyle style) {
  if (date.length < 8) return date;
  List<String> dateParts = [];
  dateParts.add(date.substring(0, 4));
  dateParts.add(date.substring(4, 6));
  dateParts.add(date.substring(6, 8));

  switch (style) {
    case DateStyle.hidden:
      return '';
    case DateStyle.none:
      return date.substring(0, 8);
    case DateStyle.chinese:
      return '${dateParts[0]}年${dateParts[1]}月${dateParts[2]}日';
    case DateStyle.space:
      return '${dateParts[0]} ${dateParts[1]} ${dateParts[2]}';
    case DateStyle.dash:
      return '${dateParts[0]}-${dateParts[1]}-${dateParts[2]}';
    case DateStyle.dot:
      return '${dateParts[0]}.${dateParts[1]}.${dateParts[2]}';
    case DateStyle.underscore:
      return '${dateParts[0]}_${dateParts[1]}_${dateParts[2]}';
  }
}

String formatShowTime(String date, TimeStyle style) {
  if (date.length < 14) return '';
  List<String> timeParts = [];
  timeParts.add(date.substring(8, 10));
  timeParts.add(date.substring(10, 12));
  timeParts.add(date.substring(12, 14));
  switch (style) {
    case TimeStyle.hidden:
      return '';
    case TimeStyle.none:
      return '${timeParts[0]}${timeParts[1]}${timeParts[2]}';
    case TimeStyle.chinese:
      return '${timeParts[0]}时${timeParts[1]}分${timeParts[2]}秒';
    case TimeStyle.english:
      return '${timeParts[0]}h${timeParts[1]}m${timeParts[2]}s';
    case TimeStyle.dash:
      return '${timeParts[0]}-${timeParts[1]}-${timeParts[2]}';
    case TimeStyle.dot:
      return '${timeParts[0]}.${timeParts[1]}.${timeParts[2]}';
    case TimeStyle.underscore:
      return '${timeParts[0]}_${timeParts[1]}_${timeParts[2]}';
    case TimeStyle.space:
      return '${timeParts[0]} ${timeParts[1]} ${timeParts[2]}';
  }
}

int formatVersionNum(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
}
