import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/action_bar/upload_input.dart';

class PrefixTextInput extends HookConsumerWidget {
  const PrefixTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String prefixLabel = '前缀';
    const String prefixTextHint = '添加前缀内容';
    const String prefixCycleTip = '循环前缀文件内容';

    final prefixTextController = useTextEditingController();
    final prefixInputShow = useState(false);
    prefixTextController.addListener(() {
      prefixInputShow.value = prefixTextController.text.isNotEmpty;
      ref.read(prefixTextProvider.notifier).update(prefixTextController.text);
    });

    return CommonInputMenu(
      label: prefixLabel,
      slot: UploadInput(
        controller: prefixTextController,
        hintText: prefixTextHint,
        show: prefixInputShow.value,
      ),
      message: prefixCycleTip,
      icon: AppIcons.cycle,
      selected: ref.watch(cyclePrefixProvider),
      onTap: ref.read(cyclePrefixProvider.notifier).update,
    );
  }
}
