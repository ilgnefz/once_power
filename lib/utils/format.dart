import 'package:flutter/material.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/models/file.dart';

int formatToInt(String value) {
  RegExpMatch? match = RegExp(r'\d+').firstMatch(value);
  if (match != null) return int.parse(match.group(0)!);
  return 0;
}

String formatNum(int n, int width) {
  if (width == 0) return '';
  if (n.toString().length > width) return n.toString();
  return n.toString().padLeft(width, '0');
}

String formatTimeNum(int num) => num.toString().padLeft(2, '0');

String formatDateTime(DateTime dateTime) {
  String m = formatTimeNum(dateTime.month);
  String d = formatTimeNum(dateTime.day);
  String h = formatTimeNum(dateTime.hour);
  String min = formatTimeNum(dateTime.minute);
  String s = formatTimeNum(dateTime.second);
  return '${dateTime.year}$m$d$h$min$s';
}

DateTime? formatExifDate(String? date) {
  if (date == null) return null;
  List<String> list = date.split(' ');
  String ymd = list.first.replaceAll(':', '-');
  list.replaceRange(0, 1, [ymd]);
  return DateTime.parse(list.join(' '));
}

String formatVideoTime(Duration total, Duration current) {
  String currentM = formatTimeNum(current.inMinutes);
  String currentS = formatTimeNum(current.inSeconds.remainder(60));
  String totalM = formatTimeNum(total.inMinutes);
  String totalS = formatTimeNum(total.inSeconds.remainder(60));
  return '$currentM:$currentS / $totalM:$totalS';
}

String formatResolution(Resolution resolution) =>
    '${resolution.width} x ${resolution.height}';

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

List<String> strToList(String content) {
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

String formatDouble(double value) {
  if (value == value.toInt().toDouble()) {
    return value.toInt().toString();
  }
  return value.toString();
}

String formatShowDate(String date, DateShowType type) {
  if (date.length < 8) return date;
  List<String> dateParts = [];
  dateParts.add(date.substring(0, 4));
  dateParts.add(date.substring(4, 6));
  dateParts.add(date.substring(6, 8));

  switch (type) {
    case DateShowType.hidden:
      return '';
    case DateShowType.none:
      return date.substring(0, 8);
    case DateShowType.chinese:
      return '${dateParts[0]}年${dateParts[1]}月${dateParts[2]}日';
    case DateShowType.space:
      return '${dateParts[0]} ${dateParts[1]} ${dateParts[2]}';
    case DateShowType.dash:
      return '${dateParts[0]}-${dateParts[1]}-${dateParts[2]}';
    case DateShowType.dot:
      return '${dateParts[0]}.${dateParts[1]}.${dateParts[2]}';
    case DateShowType.underscore:
      return '${dateParts[0]}_${dateParts[1]}_${dateParts[2]}';
  }
}

String formatShowTime(String date, TimeShowType type) {
  if (date.length < 14) return '';
  List<String> timeParts = [];
  timeParts.add(date.substring(8, 10));
  timeParts.add(date.substring(10, 12));
  timeParts.add(date.substring(12, 14));
  switch (type) {
    case TimeShowType.hidden:
      return '';
    case TimeShowType.none:
      return '${timeParts[0]}${timeParts[1]}${timeParts[2]}';
    case TimeShowType.chinese:
      return '${timeParts[0]}时${timeParts[1]}分${timeParts[2]}秒';
    case TimeShowType.english:
      return '${timeParts[0]}h${timeParts[1]}m${timeParts[2]}s';
    case TimeShowType.dash:
      return '${timeParts[0]}-${timeParts[1]}-${timeParts[2]}';
    case TimeShowType.dot:
      return '${timeParts[0]}.${timeParts[1]}.${timeParts[2]}';
    case TimeShowType.underscore:
      return '${timeParts[0]}_${timeParts[1]}_${timeParts[2]}';
    case TimeShowType.space:
      return '${timeParts[0]} ${timeParts[1]} ${timeParts[2]}';
  }
}

int formatVersionNum(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
}

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

String reassembleStr(String name, String input, int length) {
  if (name.isEmpty) return name;
  if (length <= 0) throw ArgumentError('Length must be positive');

  List<String> result = [];
  for (int i = 0; i < name.length; i += length) {
    int end = (i + length < name.length) ? i + length : name.length;
    result.add(name.substring(i, end));
  }
  return result.join(input);
}
