import 'package:flutter/material.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/utils/notification.dart';

class BottomClickText extends StatefulWidget {
  const BottomClickText({super.key});

  @override
  State<BottomClickText> createState() => _BottomClickTextState();
}

class _BottomClickTextState extends State<BottomClickText> {
  bool hover = false;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: InkWell(
        onHover: (v) {
          hover = v;
          setState(() {});
        },
        onTap: check
            ? null
            : () async {
                check = true;
                await Future.delayed(const Duration(seconds: 3));
                NotificationMessage.show(
                    '检测完成', '当前已是最新版本', [], MessageType.success);
                check = false;
                setState(() {});
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              check ? '检测中' : '检测更新',
              style: TextStyle(
                fontSize: 13,
                color: hover ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            if (check)
              Container(
                margin: const EdgeInsets.only(left: 4),
                width: 12,
                height: 12,
                child: const FittedBox(
                  fit: BoxFit.fill,
                  child: CircularProgressIndicator(strokeWidth: 6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
