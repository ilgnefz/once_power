import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/notification.dart';
import 'package:once_power/models/notification.dart';

void showCopyNotification(String message) {
  NotificationInfo(
    title: tr(AppL10n.successCopy),
    time: 2,
    message: message,
  ).show();
}

void showEmptyNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errEmptyTitle),
    message: tr(AppL10n.errEmpty),
    time: 2,
  ).show();
}

void showSuspenseErrorNotification() {}

showTxtDecodeNotification(String err) {}
