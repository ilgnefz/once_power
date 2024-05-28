String formatDateTime(DateTime dateTime) {
  // DateTime dateTime = DateTime.parse(dateTimeStr);
  String formattedDateTime = '${dateTime.year}'
      '${dateTime.month.toString().padLeft(2, '0')}'
      '${dateTime.day.toString().padLeft(2, '0')}'
      '${dateTime.hour.toString().padLeft(2, '0')}'
      '${dateTime.minute.toString().padLeft(2, '0')}'
      '${dateTime.second.toString().padLeft(2, '0')}';
  return formattedDateTime;
}

String formatNumber(int n, int width) {
  if (width == 0) return '';
  return n.toString().padLeft(width, '0');
}

DateTime formatExifDate(String date) {
  List<String> list = date.split(' ');
  String ymd = list.first.replaceAll(':', '-');
  list.replaceRange(0, 1, [ymd]);
  return DateTime.parse(list.join(' '));
}

int getVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
}

int getNum(String value) {
  RegExp exp = RegExp(r'\d+');
  RegExpMatch? match = exp.firstMatch(value);
  if (match != null) return int.parse(match.group(0)!);
  return 0;
}

String fileName(String name, String extension) {
  if (extension == '' || extension == 'dir') return name;
  return '$name.$extension';
}
