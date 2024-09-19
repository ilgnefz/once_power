import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/action_menu.dart';
import 'package:once_power/widgets/action_bar/upload_input.dart';

class PrefixInput extends ConsumerWidget {
  const PrefixInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String prefixLabel = S.of(context).prefix;
    final String prefixTextHint = S.of(context).prefixContent;
    final String prefixCycleTip = S.of(context).circularPrefixDesc;

    void toggleCycle() {
      ref.read(cyclePrefixProvider.notifier).update();
      updateName(ref);
    }

    return ActionMenu(
      label: prefixLabel,
      slot: UploadInput(
        controller: ref.watch(prefixControllerProvider),
        hintText: prefixTextHint,
        show: ref.watch(prefixClearProvider),
        onChanged: (v) => updateName(ref),
        type: FileUploadType.prefix,
      ),
      message: prefixCycleTip,
      icon: AppIcons.cycle,
      selected: ref.watch(cyclePrefixProvider),
      onTap: toggleCycle,
    );
  }
}
