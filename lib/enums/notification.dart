import 'package:flutter/material.dart';
import 'package:once_power/constants/icons.dart';

enum NotificationType {
  success(Colors.green, AppIcons.success),
  error(Colors.red, AppIcons.error),
  warning(Colors.orange, AppIcons.warning);

  final Color color;
  final String icon;
  const NotificationType(this.color, this.icon);
}

extension NotificationTypeExtension on NotificationType {
  bool isSuccess() => this == NotificationType.success;
  bool isError() => this == NotificationType.error;
  bool isWarning() => this == NotificationType.warning;
}
