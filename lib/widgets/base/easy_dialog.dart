import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

import 'dialog_background.dart';

class EasyDialog extends StatelessWidget {
  const EasyDialog({
    super.key,
    required this.title,
    this.width,
    this.padding,
    required this.content,
    this.okText,
    this.cancelText,
    this.onOk,
    this.onCancel,
    this.actions,
    this.extraButton,
    this.actionsSpacing,
    this.actionsAxisAlignment = MainAxisAlignment.spaceBetween,
    this.onModelTap,
  });

  final String title;
  final double? width;
  final EdgeInsets? padding;
  final Widget content;
  final String? okText;
  final String? cancelText;
  final void Function()? onOk;
  final void Function()? onCancel;
  final List<Widget>? actions;
  final Widget? extraButton;
  final double? actionsSpacing;
  final MainAxisAlignment actionsAxisAlignment;
  final void Function()? onModelTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.primaryColor,
    );
    return DialogBackground(
      onModelTap: onModelTap,
      child: UnconstrainedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: theme.scaffoldBackgroundColor,
            child: Container(
              width: width ?? AppNum.easyDialog,
              padding: padding ?? EdgeInsets.all(AppNum.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                spacing: AppNum.spaceLarge,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content,
                  Row(
                    spacing: actionsSpacing ?? AppNum.spaceLarge,
                    mainAxisAlignment: actionsAxisAlignment,
                    children:
                        actions ??
                        [
                          if (extraButton != null) ...[extraButton!, Spacer()],
                          TextButton(
                            onPressed: onCancel,
                            child: Text(cancelText!, style: textStyle),
                          ),
                          TextButton(
                            onPressed: onOk,
                            child: Text(okText!, style: textStyle),
                          ),
                        ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
