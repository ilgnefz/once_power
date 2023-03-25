import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/widgets/my_text.dart';

class Toast {
  static show(String title, String message, MessageType type) {
    BotToast.showCustomNotification(
      toastBuilder: (context) {
        return Container(
          width: 600,
          padding: const EdgeInsets.only(left: 16, right: 12, bottom: 12),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 12),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  MyText(
                    title,
                    fontSize: 14,
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
              MyText(message, fontSize: 14),
            ],
          ),
        );
      },
      duration: const Duration(seconds: 5),
      align: Alignment.topRight,
    );
  }
}
