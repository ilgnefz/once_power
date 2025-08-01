import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class TipBtn extends ConsumerWidget {
  const TipBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String tip1 = S.of(context).shortcutKey;
    String tip2 = S.of(context).selectedAll;
    String tip3 = S.of(context).deleteSelected;
    String tip4 = S.of(context).toggleSelected;
    String tip5 = S.of(context).suspenseFile;
    String tip6 = S.of(context).takeOutFront;
    String tip7 = S.of(context).takeOutBehind;
    return TooltipIcon(
      tip:
          '$tip1:\nCtrl+A  $tip2\nDelete  $tip3\nCtrl+S  $tip4\nCtrl+X  $tip5\nCtrl+C  $tip6\nCtrl+V  $tip7',
      icon: Icons.tips_and_updates_rounded,
      selected: false,
      onTap: () {},
    );
  }
}
