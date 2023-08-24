import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/action_bar/upload_input.dart';

class SuffixTextInput extends HookConsumerWidget {
  const SuffixTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String suffixLabel = '后缀';
    const String suffixTextHint = '添加后缀内容';
    const String suffixCycleTip = '循环后缀文件内容';

    // final suffixTextController = useTextEditingController();
    // final suffixInputShow = useState(false);
    // suffixTextController.addListener(() {
    //   suffixInputShow.value = suffixTextController.text.isNotEmpty;
    //   ref.read(suffixTextProvider.notifier).update(suffixTextController.text);
    // });

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
      onTap: () {
        ref.read(cycleSuffixProvider.notifier).update();
        updateName(ref);
      },
    );
  }
}
