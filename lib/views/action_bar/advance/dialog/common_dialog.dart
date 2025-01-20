import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/common/easy_dialog.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    this.autoPop = true,
    required this.title,
    required this.child,
    required this.onOk,
  });

  final bool autoPop;
  final String title;
  final Widget child;
  final void Function() onOk;

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: title,
      extraContent: child,
      okText: S.of(context).ok,
      cancelText: S.of(context).cancel,
      onOk: () {
        if (autoPop) Navigator.of(context).pop();
        onOk();
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    );
  }
}
