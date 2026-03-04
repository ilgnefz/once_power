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

String formatTimeNum(int num) => num.toString().padLeft(2, '0');

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
