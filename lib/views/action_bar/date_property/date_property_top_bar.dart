import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/one_line_text.dart';

class DatePropertyTopBar extends ConsumerWidget {
  const DatePropertyTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: AppNum.modeCardH,
      padding: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OneLineText(S.of(context).modifiedFileDate),
          TextButton(
            onPressed: () =>
                ref.read(useDateModifyProvider.notifier).update(false),
            child: Text(S.of(context).exit),
          ),
        ],
      ),
    );
  }
}
