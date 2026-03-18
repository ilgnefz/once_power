import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';

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
    this.autoPop = true,
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
  final bool autoPop;
  final MainAxisAlignment actionsAxisAlignment;
  final void Function()? onModelTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.primaryColor,
    );
    return UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.95,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: theme.scaffoldBackgroundColor,
          child: Container(
            width: width ?? AppNum.easyDialog,
            padding: EdgeInsets.symmetric(vertical: AppNum.padding),
            decoration: BoxDecoration(borderRadius: .circular(8)),
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
                // Padding(
                //   padding: padding ?? .symmetric(horizontal: AppNum.padding),
                //   child: content,
                // ),
                Flexible(
                  child: Padding(
                    padding: padding ?? .symmetric(horizontal: AppNum.padding),
                    child: content,
                  ),
                ),
                Padding(
                  padding: .symmetric(horizontal: AppNum.padding),
                  child: Row(
                    spacing: actionsSpacing ?? AppNum.spaceLarge,
                    mainAxisAlignment: actionsAxisAlignment,
                    children:
                        actions ??
                        [
                          if (extraButton != null) ...[extraButton!, Spacer()],
                          TextButton(
                            onPressed: () {
                              onCancel?.call();
                              Navigator.pop(context);
                            },
                            child: Text(
                              cancelText ?? tr(AppL10n.dialogExit),
                              style: textStyle,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onOk?.call();
                              if (autoPop) Navigator.pop(context);
                            },
                            child: Text(
                              okText ?? tr(AppL10n.dialogOk),
                              style: textStyle,
                            ),
                          ),
                        ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
