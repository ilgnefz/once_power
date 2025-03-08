import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class CountCheckbox extends ConsumerWidget {
  const CountCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selected = ref.watch(selectFileProvider);
    int total = ref.watch(fileListProvider).length;

    String label = ref.watch(currentModeProvider).isOrganize
        ? S.of(context).fileName
        : S.of(context).originalName;

    return EasyCheckbox(
      label: '$label ($selected/$total)',
      checked: ref.watch(selectAllProvider),
      onChanged: (value) => selectAll(ref),
    );
  }
}
