import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/widgets/common/notification_animation.dart';
import 'package:once_power/widgets/common/notification_content.dart';

class NotificationInfo {
  NotificationType type;
  String title;
  String message;
  List<InfoDetail> detailList;
  int? time;

  NotificationInfo({
    this.type = NotificationType.success,
    this.title = '',
    this.message = '',
    this.detailList = const [],
    this.time,
  });

  @override
  String toString() {
    return "NotificationInfo(type: $type, title: $title, message: $message, detailList: $detailList)";
  }

  void show() {
    Duration? duration = Duration(seconds: 5);
    if (type.isError() && time == null) duration = null;
    BotToast.showCustomNotification(
      toastBuilder: (cf) => NotificationContent(
        cf: cf,
        info: NotificationInfo(
            type: type, title: title, message: message, detailList: detailList),
      ),
      align: Alignment.bottomRight,
      duration: duration,
      onlyOne: true,
      wrapToastAnimation: (controller, cancelFunc, child) =>
          NotificationAnimation(
              reverse: true, controller: controller, child: child),
    );
  }
}

class InfoDetail {
  final String file;
  final String message;

  InfoDetail({
    required this.file,
    required this.message,
  });

  @override
  String toString() {
    return 'InfoDetail{file: $file, message: $message}';
  }
}
