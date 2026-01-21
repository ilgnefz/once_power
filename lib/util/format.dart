int extractNum(String value) {
  final match = RegExp(r'\d+').firstMatch(value);
  final currentValue = match != null ? int.parse(match.group(0)!) : 0;
  return currentValue;
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

DateTime intToDateTime(int time) =>
    DateTime.fromMillisecondsSinceEpoch(time * 1000);

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
