import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/widgets/my_text.dart';

class NotificationMessage {
  static show(String title, String message, MessageType type,
      [void Function()? onPressed]) {
    BotToast.showCustomNotification(
      toastBuilder: (context) {
        return Container(
          width: 600,
          padding: EdgeInsets.only(
              left: 16, right: 12, bottom: onPressed == null ? 12 : 0),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 12),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    MyText(
                      title,
                      fontWeight: FontWeight.w600,
                      color: type == MessageType.failure
                          ? Colors.red
                          : type == MessageType.success
                              ? Colors.green
                              : Colors.orangeAccent,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: context.call,
                      icon: const Icon(Icons.close),
                      iconSize: 16,
                    ),
                  ],
                ),
                MyText(message),
                if (onPressed != null)
                  ButtonBar(
                    children: [
                      TextButton(
                        onPressed: onPressed,
                        child: MyText(S.current.copyErrorMessage),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
      duration: type == MessageType.failure ? null : const Duration(seconds: 5),
      align: Alignment.topRight,
    );
  }
}
