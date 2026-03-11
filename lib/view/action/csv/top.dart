import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';

class CSVTop extends ConsumerWidget {
  const CSVTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: AppNum.actionWidth,
      height: AppNum.topHeight,
      padding: .symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: .spaceBetween,
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
