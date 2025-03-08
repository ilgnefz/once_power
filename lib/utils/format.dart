import 'package:once_power/models/two_re_enum.dart';
import 'package:path/path.dart' as path;

// TODO: 有些代码不适合在这
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
  // TODO: 是否严严格一点返回数字
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

// String getFolderName(String folder) => path.basename(folder);

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
