import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/enums/notification.dart';
import 'package:once_power/views/notification/animation.dart';
import 'package:once_power/views/notification/content.dart';

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
    if (time != null) duration = Duration(seconds: time!);
    BotToast.showCustomNotification(
      toastBuilder: (cf) => NotificationContent(
        cf: cf,
        info: NotificationInfo(
          type: type,
          title: title,
          message: message,
          detailList: detailList,
        ),
      ),
      align: Alignment.bottomRight,
      duration: duration,
      onlyOne: true,
      wrapToastAnimation: (controller, cancelFunc, child) =>
          NotificationAnimation(
            reverse: true,
            controller: controller,
            child: child,
          ),
    );
  }
}

class InfoDetail {
  final String file;
  final String message;

  InfoDetail({required this.file, required this.message});

  @override
  String toString() {
    return 'InfoDetail{file: $file, message: $message}';
  }
}
