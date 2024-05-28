import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/widgets/input/input.dart';

class SuffixTextInput extends ConsumerWidget {
  const SuffixTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String suffixLabel = S.of(context).suffix;
    final String suffixTextHint = S.of(context).suffixContent;
    final String suffixCycleTip = S.of(context).circularSuffixDesc;

    void toggleCycle() {
      ref.read(cycleSuffixProvider.notifier).update();
      updateName(ref);
    }

    return CommonInputMenu(
      label: suffixLabel,
      slot: UploadInput(
        controller: ref.watch(suffixControllerProvider),
        hintText: suffixTextHint,
        show: ref.watch(suffixClearProvider),
        onChanged: (v) => updateName(ref),
        type: FileUploadType.suffix,
      ),
      message: suffixCycleTip,
      icon: AppIcons.cycle,
      selected: ref.watch(cycleSuffixProvider),
      onTap: toggleCycle,
    );
  }
}
