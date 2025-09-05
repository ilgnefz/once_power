import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/widgets/base/svg_icon.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({super.key, required this.cf, required this.info});

  final CancelFunc cf;
  final NotificationInfo info;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: EdgeInsets.only(top: 12, bottom: 44, right: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 8),
        ],
      ),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgIcon(info.type.icon, color: info.type.color, size: 18),
              const SizedBox(width: 4),
              Text(info.title, style: TextStyle(color: info.type.color)),
              const Spacer(),
              ClickIcon(
                icon: Icons.close,
                onPressed: cf.call,
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
                  TextStyle fileStyle = TextStyle(
                        color: Colors.blue,
                        fontFamily: defaultFont,
                      ),
                      infoStyle = TextStyle(
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
