import 'package:once_power/models/advance_menu_enum.dart';

String formatDateTime(DateTime dateTime) {
  String formattedDateTime = '${dateTime.year}'
      '${dateTime.month.toString().padLeft(2, '0')}'
      '${dateTime.day.toString().padLeft(2, '0')}'
      '${dateTime.hour.toString().padLeft(2, '0')}'
      '${dateTime.minute.toString().padLeft(2, '0')}'
      '${dateTime.second.toString().padLeft(2, '0')}';
  return formattedDateTime;
}

String formatNum(int n, int width) {
  if (width == 0) return '';
  if (n.toString().length > width) return n.toString();
  return n.toString().padLeft(width, '0');
}

DateTime formatExifDate(String date) {
  List<String> list = date.split(' ');
  String ymd = list.first.replaceAll(':', '-');
  list.replaceRange(0, 1, [ymd]);
  return DateTime.parse(list.join(' '));
}

int formatVersionNum(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
}

String formatVideoTime(Duration total, Duration current) {
  String currentM = formatNum(current.inMinutes, 2);
  String currentS = formatNum(current.inSeconds.remainder(60), 2);
  String totalM = formatNum(total.inMinutes, 2);
  String totalS = formatNum(total.inSeconds.remainder(60), 2);
  return '$currentM:$currentS / $totalM:$totalS';
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

/// 将字节数转换为友好格式
/// 示例：1024 → 1.0 KB | 1536 → 1.5 KB | 2500000 → 2.38 MB | 1500000000 → 1.40 GB
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

String formatDateShow(String date, DateSplitType type) {
  List<String> dateParts = [];
  dateParts.add(date.substring(0, 4));
  dateParts.add(date.substring(4, 6));
  dateParts.add(date.substring(6, 8));
  // dateParts.add(date.substring(8, 10));
  // dateParts.add(date.substring(10, 12));
  // dateParts.add(date.substring(12, 14));

  switch (type) {
    case DateSplitType.none:
      return date;
    case DateSplitType.chinese:
      date = '${dateParts[0]}年${dateParts[1]}月${dateParts[2]}日';
      break;
    case DateSplitType.space:
      date = '${dateParts[0]} ${dateParts[1]} ${dateParts[2]}';
      break;
    case DateSplitType.dash:
      date = '${dateParts[0]}-${dateParts[1]}-${dateParts[2]}';
      break;
    case DateSplitType.dot:
      date = '${dateParts[0]}.${dateParts[1]}.${dateParts[2]}';
      break;
    case DateSplitType.underscore:
      date = '${dateParts[0]}_${dateParts[1]}_${dateParts[2]}';
      break;
  }
  return date;
}

String formatDouble(double value) {
  if (value == value.toInt().toDouble()) {
    return value.toInt().toString();
  }
  return value.toString();
}
