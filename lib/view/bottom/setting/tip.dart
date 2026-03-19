import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/text.dart';

class TipPanel extends StatelessWidget {
  const TipPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final String all = tr(AppL10n.settingHotKeyAll);
    final String cancel = tr(AppL10n.settingHotKeyCancel);
    final String delete = tr(AppL10n.settingHotKeyDelete);
    final String toggle = tr(AppL10n.settingHotKeyToggle);
    final String suspense = tr(AppL10n.settingHotKeySuspense);
    final String front = tr(AppL10n.settingHotKeyFront);
    final String behind = tr(AppL10n.settingHotKeyBehind);

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            TableBaseText('Ctrl+A  $all'),
            TableBaseText('Ctrl+D  $cancel'),
            TableBaseText('Delete  $delete'),
          ],
        ),
        TableRow(
          children: [
            TableBaseText('Ctrl+S  $toggle'),
            TableBaseText('Ctrl+X  $suspense'),
            TableBaseText('Ctrl+C  $front'),
          ],
        ),
        TableRow(
          children: [
            TableBaseText('Ctrl+V  $behind'),
            const SizedBox(),
            const SizedBox(),
          ],
        ),
      ],
    );
  }
}

class TableBaseText extends StatelessWidget {
  const TableBaseText(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.widgetHeight,
      alignment: Alignment.centerLeft,
      child: BaseText(label),
    );
  }
}
