import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';

class CsvDataTop extends ConsumerWidget {
  const CsvDataTop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: AppNum.action,
      height: AppNum.actionTop,
      padding: const EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        spacing: AppNum.spaceMedium,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: '${tr(AppL10n.csvTitle)} ',
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: ref.watch(cSVNameColumnProvider),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              ref.read(cSVDataProvider.notifier).update([]);
              updateName(ref);
            },
            child: Text(
              tr(AppL10n.csvExit),
              style: TextStyle(fontFamily: defaultFont, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
