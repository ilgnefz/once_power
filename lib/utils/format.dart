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

DateTime formatExifDate(String date) {
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
  const units = ['B', 'KB', 'MB', 'GB'];
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
