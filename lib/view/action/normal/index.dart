import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/common/digit_input.dart';

class IndexInput extends ConsumerWidget {
  const IndexInput({
    super.key,
    required this.label,
    required this.tip,
    this.swapProvider,
    this.digitProvider,
    this.startProvider,
  });

  final String label;
  final String tip;
  final dynamic swapProvider;
  final dynamic digitProvider;
  final dynamic startProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: label,
      tip: tip,
      icon: AppIcons.swap,
      checked: ref.watch(swapProvider),
      onPressed: () {
        ref.read(swapProvider.notifier).update();
        Debounce.run(() => normalUpdateName(ref));
      },
      child: Row(
        spacing: AppNum.spaceMedium,
        children: [
          DigitInput(
            value: ref.watch(digitProvider),
            unit: tr(AppL10n.renameWidth),
            onChanged: (value) {
              ref.read(digitProvider.notifier).update(value);
              Debounce.run(() => normalUpdateName(ref));
            },
          ),
          DigitInput(
            value: ref.watch(startProvider),
            unit: tr(AppL10n.renameStart),
            onChanged: (value) {
              ref.read(startProvider.notifier).update(value);
              Debounce.run(() => normalUpdateName(ref));
            },
          ),
        ],
      ),
    );
  }
}
