import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widgets/base/one_line_text.dart';
import 'package:once_power/widgets/common/click_icon.dart';

final titleProvider = Provider<String>((ref) {
  String presetName = ref.watch(currentPresetNameProvider);
  int len = ref.watch(advanceMenuListProvider).length;
  String title = tr(AppL10n.advanceCount, namedArgs: {"count": "$len"});
  if (presetName.isNotEmpty) title += ' - $presetName';
  return title;
});

class AdvanceTop extends ConsumerWidget {
  const AdvanceTop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: AppNum.top,
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OneLineText(
            ref.watch(titleProvider),
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          ClickIcon(
            size: 20,
            iconSize: 16,
            icon: Icons.delete_outline_rounded,
            color: Colors.grey,
            onPressed: () {
              ref.read(advanceMenuListProvider.notifier).setList([]);
              ref.read(currentPresetNameProvider.notifier).update('');
              //   TODO: 更新名称
            },
          ),
        ],
      ),
    );
  }
}
