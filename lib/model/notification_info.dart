class NotificationInfo {
  String file;
  String message;

  NotificationInfo({
    required this.file,
    required this.message,
  });

  @override
  String toString() => 'NotificationInfo{file: $file, message: $message}';
}
