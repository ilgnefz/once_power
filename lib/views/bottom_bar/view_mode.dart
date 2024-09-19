import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class ViewModeBtn extends ConsumerWidget {
  const ViewModeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tip = S.of(context).viewMode;

    bool selected = ref.watch(viewModeProvider);

    void toggleView() {
      if (!selected) {
        final provider = ref.read(fileListProvider.notifier);
        provider.removeOtherClassify(FileClassify.image);
      }
      ref.read(viewModeProvider.notifier).update();
    }

    return TooltipIcon(
      message: tip,
      icon: AppIcons.image,
      selected: selected,
      onTap: toggleView,
    );
  }
}
