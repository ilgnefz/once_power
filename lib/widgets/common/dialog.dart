import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/widgets/base/easy_dialog.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    this.autoPop = true,
    required this.title,
    required this.child,
    this.extraButton,
    this.onModelTap,
    this.onOk,
    this.onCancel,
  });

  final bool autoPop;
  final String title;
  final Widget child;
  final Widget? extraButton;
  final void Function()? onOk;
  final void Function()? onCancel;
  final void Function()? onModelTap;

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: title,
      content: child,
      okText: tr(AppL10n.dialogOk),
      cancelText: tr(AppL10n.dialogCancel),
      extraButton: extraButton,
      onModelTap: onModelTap,
      onOk: () {
        if (autoPop) Navigator.of(context).pop();
        onOk?.call();
      },
      onCancel: () {
        Navigator.of(context).pop();
        onCancel?.call();
      },
    );
  }
}
