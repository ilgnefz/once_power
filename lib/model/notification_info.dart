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

sealed class NotificationType {
  final String title;
  final String message;
  final List<NotificationInfo> infoList;

  NotificationType(this.title, this.message, [this.infoList = const []]);
}

class SuccessNotification extends NotificationType {
  SuccessNotification(super.title, super.message, [super.infoList]);
}

class ErrorNotification extends NotificationType {
  ErrorNotification(super.title, super.message, [super.infoList]);
}
