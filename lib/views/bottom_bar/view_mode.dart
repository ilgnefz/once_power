import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

import '../../cores/update_name.dart';

class ViewModeBtn extends ConsumerWidget {
  const ViewModeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: S.of(context).viewMode,
      svg: AppIcons.image,
      selected: ref.watch(isViewModeProvider),
      onTap: () {
        ref.read(isViewModeProvider.notifier).update();
        filterFile(context, ref);
        updateName(ref);
      },
    );
  }
}
