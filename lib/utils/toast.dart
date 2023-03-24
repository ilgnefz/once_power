import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/model/my_type.dart';
import 'package:once_power/widgets/my_text.dart';

class Toast {
  static show(String message, MessageType type) {
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
                    type == MessageType.failure ? '更新失败' : '更新成功',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        type == MessageType.failure ? Colors.red : Colors.green,
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
