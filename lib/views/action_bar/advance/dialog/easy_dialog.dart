import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

class EasyDialog extends StatelessWidget {
  const EasyDialog({
    super.key,
    this.icon,
    required this.title,
    this.content,
    this.extraContent,
    required this.okText,
    required this.cancelText,
    this.onOk,
    this.onCancel,
    this.actions,
  });

  final String title;
  final IconData? icon;
  final String? content;
  final Widget? extraContent;
  final String? okText;
  final String? cancelText;
  final void Function()? onOk;
  final void Function()? onCancel;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 408,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              // spacing: AppNum.largeG,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  spacing: AppNum.smallG,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) Icon(icon!, color: Colors.blue, size: 20),
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: AppNum.largeG + AppNum.smallG),
                if (content != null) Text(content!),
                if (extraContent != null) extraContent!,
                SizedBox(height: AppNum.largeG),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions ??
                      [
                        TextButton(
                            onPressed: onCancel, child: Text(cancelText!)),
                        TextButton(onPressed: onOk, child: Text(okText!)),
                      ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
