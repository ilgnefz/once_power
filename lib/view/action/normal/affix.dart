import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/action/upload_input.dart';

class AffixInput extends ConsumerWidget {
  const AffixInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.tip,
    required this.controllerProvider,
    required this.info,
    required this.cycleProvider,
    required this.onUpload,
  });

  final String label;
  final String hintText;
  final String tip;
  final dynamic controllerProvider;
  final dynamic info;
  final dynamic cycleProvider;
  final void Function(WidgetRef, String) onUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: label,
      tip: tip,
      icon: AppIcons.cycle,
      checked: ref.watch(cycleProvider),
      onPressed: () {
        ref.read(cycleProvider.notifier).filesUpdate();
        Debounce.run(() => normalUpdateName(ref));
      },
      child: UploadInput(
        controller: controllerProvider,
        hintText: hintText,
        infoProvider: info,
        onUpload: (value) => onUpload(ref, value),
      ),
    );
  }
}
