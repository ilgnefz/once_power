import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/input/input.dart';

class PrefixTextInput extends ConsumerWidget {
  const PrefixTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String prefixLabel = '前缀';
    const String prefixTextHint = '添加前缀内容';
    const String prefixCycleTip = '循环前缀文件内容';

    void toggleCycle() {
      ref.read(cyclePrefixProvider.notifier).update();
      updateName(ref);
    }

    return CommonInputMenu(
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
