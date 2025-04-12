import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/providers/toggle.dart';

class EasyDialog extends StatelessWidget {
  const EasyDialog({
    super.key,
    this.icon,
    required this.title,
    this.width,
    this.content,
    this.extraContent,
    this.okText,
    this.cancelText,
    this.onOk,
    this.onCancel,
    this.actions,
    this.extraButton,
    this.actionsSpacing = 0,
    this.actionsAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final String title;
  final IconData? icon;
  final double? width;
  final String? content;
  final Widget? extraContent;
  final String? okText;
  final String? cancelText;
  final void Function()? onOk;
  final void Function()? onCancel;
  final List<Widget>? actions;
  final Widget? extraButton;
  final double actionsSpacing;
  final MainAxisAlignment actionsAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Consumer(
            builder: (context, ref, child) {
              bool isMax = ref.watch(isMaxProvider);
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: EdgeInsets.all(isMax ? 0.0 : 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isMax ? 0 : 8),
                      color: Colors.black.withValues(alpha: .4),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: UnconstrainedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width ?? AppNum.easyDialogW,
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
                          if (icon != null)
                            Icon(icon!, color: Colors.blue, size: 20),
                          Text(title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: AppNum.largeG + AppNum.smallG),
                      if (content != null) Text(content!),
                      if (extraContent != null) extraContent!,
                      SizedBox(height: AppNum.largeG),
                      Row(
                        spacing: actionsSpacing,
                        mainAxisAlignment: actionsAxisAlignment,
                        children: actions ??
                            [
                              if (extraButton != null) ...[
                                extraButton!,
                                Spacer()
                              ],
                              TextButton(
                                  onPressed: onCancel,
                                  child: Text(cancelText!)),
                              if (extraButton != null)
                                SizedBox(width: AppNum.largeG),
                              TextButton(onPressed: onOk, child: Text(okText!)),
                            ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
