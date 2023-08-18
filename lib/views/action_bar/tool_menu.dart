import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/action_bar/date_selected.dart';
import 'package:once_power/views/action_bar/differ_menu.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/action_bar/upload_input.dart';
import 'package:once_power/widgets/digit_input.dart';

class ToolMenu extends HookConsumerWidget {
  const ToolMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String matchTextHint = '请输入内容';
    const String lengthTip = '输入内容长度';
    const String dateLabel = '日期';
    const String dateTip = '以日期命名';
    const String prefixLabel = '前缀';
    const String prefixTextHint = '添加前缀内容';
    const String prefixCycleTip = '循环前缀文件内容';
    const String prefixSwapTip = '交换前缀和递增数字位置';
    const String suffixLabel = '后缀';
    const String suffixTextHint = '添加后缀内容';
    const String suffixCycleTip = '循环后缀文件内容';
    const String suffixSwapTip = '交换后缀和递增数字位置';
    const String increaseLabel = '增数';
    const String fileExtensionLabel = '文件扩展名';
    const String fileExtensionHint = '修改为的扩展名';
    const String fileExtensionTip = '启用修改扩展名';

    // 匹配内容
    final matchTextController = useTextEditingController();
    final matchInputShow = useState(false);
    matchTextController.addListener(() {
      matchInputShow.value = matchTextController.text.isNotEmpty;
      ref.read(matchTextProvider.notifier).update(matchTextController.text);
    });

    // 前缀
    final prefixTextController = useTextEditingController();
    final prefixInputShow = useState(false);
    prefixTextController.addListener(() {
      prefixInputShow.value = prefixTextController.text.isNotEmpty;
      ref.read(prefixTextProvider.notifier).update(prefixTextController.text);
    });

    // 后缀
    final suffixTextController = useTextEditingController();
    final suffixInputShow = useState(false);
    suffixTextController.addListener(() {
      suffixInputShow.value = suffixTextController.text.isNotEmpty;
      ref.read(suffixTextProvider.notifier).update(suffixTextController.text);
    });

    // 文件后缀名
    final fileExtController = useTextEditingController();
    final fileExtShow = useState(false);
    fileExtController.addListener(() {
      fileExtShow.value = fileExtController.text.isNotEmpty;
      ref.read(suffixTextProvider.notifier).update(fileExtController.text);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 匹配内容
        CommonInputMenu(
          controller: matchTextController,
          hintText: matchTextHint,
          show: matchInputShow.value,
          message: lengthTip,
          icon: AppIcons.ruler,
          selected: ref.watch(inputLengthProvider),
          onTap: ref.read(inputLengthProvider.notifier).update,
        ),
        const SizedBox(height: AppNum.gapW),
        // 不同菜单
        const DifferMenu(),
        const SizedBox(height: AppNum.gapW),
        // 日期命名方式
        CommonInputMenu(
          label: dateLabel,
          slot: const Row(
            children: [
              Expanded(child: DigitInput()),
              SizedBox(width: 8),
              DateSelected(),
            ],
          ),
          message: dateTip,
          icon: AppIcons.date,
          selected: ref.watch(dateRenameProvider),
          onTap: ref.read(dateRenameProvider.notifier).update,
        ),
        const SizedBox(height: AppNum.gapW),
        // 前缀
        CommonInputMenu(
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
        ),
        const SizedBox(height: AppNum.gapW),
        // 前缀递增数
        CommonInputMenu(
          label: increaseLabel,
          slot: const Row(
            children: [
              Expanded(child: DigitInput()),
              SizedBox(width: 4.0),
              Expanded(child: DigitInput()),
            ],
          ),
          message: prefixSwapTip,
          icon: AppIcons.swap,
          selected: ref.watch(swapPrefixProvider),
          onTap: ref.read(swapPrefixProvider.notifier).update,
        ),
        const SizedBox(height: AppNum.gapW),
        // 后缀
        CommonInputMenu(
          label: suffixLabel,
          slot: UploadInput(
            controller: suffixTextController,
            hintText: suffixTextHint,
            show: suffixInputShow.value,
          ),
          message: suffixCycleTip,
          icon: AppIcons.cycle,
          selected: ref.watch(cycleSuffixProvider),
          onTap: ref.read(cycleSuffixProvider.notifier).update,
        ),
        const SizedBox(height: AppNum.gapW),
        // 后缀递增数
        CommonInputMenu(
          label: increaseLabel,
          slot: const Row(
            children: [
              Expanded(child: DigitInput()),
              SizedBox(width: 4.0),
              Expanded(child: DigitInput()),
            ],
          ),
          message: suffixSwapTip,
          icon: AppIcons.swap,
          selected: ref.watch(swapSuffixProvider),
          onTap: ref.read(swapSuffixProvider.notifier).update,
        ),
        const SizedBox(height: AppNum.gapW),
        // 文件后缀名
        CommonInputMenu(
          label: fileExtensionLabel,
          controller: fileExtController,
          hintText: fileExtensionHint,
          show: fileExtShow.value,
          message: fileExtensionTip,
          icon: AppIcons.checkbox,
          selected: ref.watch(modifyExtensionProvider),
          onTap: ref.read(modifyExtensionProvider.notifier).update,
        ),
      ],
    );
  }
}

// class MatchTextLine extends StatelessWidget {
//   const MatchTextLine({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
