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
    String tip3 = S.of(context).toggleSelected;
    String tip4 = S.of(context).suspenseFile;
    String tip5 = S.of(context).takeOutFront;
    String tip6 = S.of(context).takeOutBehind;
    return TooltipIcon(
      tip:
          '$tip1:\nCtrl+A  $tip2\nCtrl+S  $tip3\nCtrl+z  $tip4\nCtrl+x  $tip5\nCtrl+c  $tip6',
      icon: Icons.tips_and_updates_rounded,
      selected: false,
      onTap: () {},
    );
  }
}
