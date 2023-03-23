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
