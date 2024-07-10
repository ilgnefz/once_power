import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';

class CsvDataTitle extends StatelessWidget {
  const CsvDataTitle(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final String tableInfo = S.of(context).tableInfo;
    final String exit = S.of(context).exit;

    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: tableInfo,
            style: const TextStyle(color: Colors.black).useSystemChineseFont(),
            children: [
              TextSpan(
                text: label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Consumer(
          builder: (context, ref, child) {
            return TextButton(
              onPressed: () {
                ref.read(cSVDataProvider.notifier).update([]);
                updateName(ref);
              },
              child: child!,
            );
          },
          child: Text(exit),
        ),
      ],
    );
  }
}
