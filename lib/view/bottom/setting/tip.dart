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
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            TableContent(keys: ['Ctrl', 'A'], label: all),
            TableContent(keys: ['Ctrl', 'D'], label: cancel),
          ],
        ),
        TableRow(
          children: [
            TableContent(keys: ['Delete'], label: delete),
            TableContent(keys: ['Ctrl', 'S'], label: toggle),
          ],
        ),
        TableRow(
          children: [
            TableContent(keys: ['Ctrl', 'X'], label: suspense),
            TableContent(keys: ['Ctrl', 'C'], label: front),
          ],
        ),
        TableRow(
          children: [
            TableContent(keys: ['Ctrl', 'V'], label: behind),
            const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}

class TableContent extends StatelessWidget {
  const TableContent({super.key, required this.keys, required this.label});

  final List<String> keys;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppNum.widgetHeight,
      child: Row(
        spacing: AppNum.spaceSmall,
        children: [
          ...keys.length > 1
              ? [KeyBox(keys.first), BaseText('+'), KeyBox(keys.last)]
              : [KeyBox(keys.single)],
          const SizedBox.shrink(),
          BaseText(label),
        ],
      ),
    );
  }
}

class KeyBox extends StatelessWidget {
  const KeyBox(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final double size = AppNum.widgetHeight - 4.0;
    final BorderSide side = BorderSide(color: Colors.grey, width: 1);
    return Container(
      height: size,
      padding: .symmetric(horizontal: AppNum.spaceMedium),
      alignment: .centerLeft,
      constraints: BoxConstraints(minWidth: size),
      decoration: BoxDecoration(
        borderRadius: .circular(AppNum.radiusSmall),
        border: Border(
          left: side,
          top: side,
          right: side,
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: BaseText(label),
    );
  }
}
