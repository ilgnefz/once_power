import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/enum/notification.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/common/click_icon.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({
    super.key,
    required this.cancelFunc,
    required this.info,
  });

  final CancelFunc cancelFunc;
  final NotificationInfo info;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 320,
      padding: const .symmetric(vertical: 8, horizontal: 12),
      margin: .only(bottom: 36, right: 6),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 8),
        ],
      ),
      child: Column(
        spacing: 4,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Row(
            spacing: 4,
            children: [
              BaseIcon(svg: info.type.icon, color: info.type.color, size: 18),
              Text(
                info.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: info.type.color,
                ),
              ),
              const Spacer(),
              if (info.type.isError())
                ClickIcon(
                  iconSize: 16,
                  icon: Icons.file_copy_rounded,
                  onPressed: () async {
                    String content = '';
                    for (InfoDetail detail in info.detailList) {
                      content += '${detail.file} ${detail.message}';
                    }
                    await Clipboard.setData(ClipboardData(text: content));
                    cancelFunc.call();
                  },
                  color: Colors.grey,
                ),
              ClickIcon(
                icon: Icons.close,
                onPressed: cancelFunc.call,
                color: Colors.grey,
              ),
            ],
          ),
          Text(info.message),
          if (info.detailList.isNotEmpty)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 360),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: info.detailList.length,
                itemBuilder: (BuildContext context, int index) {
                  TextStyle? fileStyle = theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                      ),
                      infoStyle = theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.labelMedium?.color,
                      );
                  return RichText(
                    text: TextSpan(
                      text: info.detailList[index].file,
                      style: fileStyle,
                      children: [
                        TextSpan(
                          text: ' ${info.detailList[index].message}',
                          style: infoStyle,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
