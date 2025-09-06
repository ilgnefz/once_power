import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/toggle.dart';

class DateTop extends ConsumerWidget {
  const DateTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppNum.actionTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppNum.padding),
            child: Text(tr(AppL10n.dateTitle)),
          ),
          TextButton(
            child: Text(tr(AppL10n.dateExit)),
            onPressed: () {
              ref.read(isDateModifyProvider.notifier).update(false);
              updateName(ref);
            },
          ),
        ],
      ),
    );
  }
}
